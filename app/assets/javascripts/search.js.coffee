"use strict"

class MoviePanel
  searchInput = ""
  # loadingGif = true
  dropDownInvisible = true
  movieInfoInvisible = true
  searchNum = 0
  movieList = []

  $( "#target" ).keydown = (event) ->
  # keyPress = (event) ->
    console.log(event)
    switch event.which
      when 40
        $('.' + searchNum).removeClass('hover')
        searchNum += 1
        if searchNum > movieList.length
          searchNum = 0
        $('.' + searchNum).addClass('hover')
        return
      when 38
        $('.' + searchNum).removeClass('hover')
        searchNum -= 1
        if searchNum < 0
          searchNum = movieList.length
        $('.' + searchNum).addClass('hover')
        return
      when 13
        if searchNum == 0
          searchPick(searchInput, 'basic')
        else
          searchPick(movieList[searchNum - 1], 'advanced')

  $( "#target" ).mouseover = (event, num) ->
    if num
      $('.' + searchNum).removeClass('hover')
      searchNum = num
    $('.' + searchNum).addClass('hover')
    return

  $( "#target" ).mouseout = (event, num) ->
    if num
      searchNum = num
    $('.' + searchNum).removeClass('hover')
    return

  search = ->
    if searchInput
      movieList = []
      # loadingGif = false
      dropDownInvisible = true
      searchNum = 0
      searchTerm = searchInput



      $http(
        url: "http://www.omdbapi.com/"
        method: "get"
        params: { s: searchTerm }
      ).success( (data, status, headers, config) ->
        console.log("data: " + data + "status: " + status + "headers:" + headers + "config: " + config)
        results(data)
      ).error( (data, status, headers, config) ->
        status = status
      )

      # $.ajax({
      #   type: "GET",
      #   url:    "/edit_comment", // should be mapped in routes.rb
      #   data: {comment:"new comment"},
      #   datatype:"html", // check more option
      #   success: function(data) {
      #            // handle response data
      #            },
      #   async:   true
      # });

      # results = (data) ->
      #   loadingGif = true
      #   unless data.Response == 'False'
      #     movieList = []
      #     dropDownInvisible = false
      #     movieNum = 1
      #     for movie in data["Search"]
      #       movie.Num = movieNum
      #       movieList.push(movie)
      #       movieNum += 1

  # searchPick = (movie, mode) ->
  #   # debugger
  #   console.log(movie + "TEST" + mode)
  #   movieInfo = {}
  #   dropDownInvisible = true
  #   movieInfoInvisible = false

    # if mode == 'basic'
    #   $http(
    #     url: "http://www.omdbapi.com/"
    #     method: "get"
    #     params: { s: movie }
    #   ).success( (data, status, headers, config) ->
    #     console.log("data: " + data + "status: " + status + "headers:" + headers + "config: " + config + "imdbID: " + movie.imdbID)
    #     searchPick(data['Search'][0], 'advanced')
    #   ).error( (data, status, headers, config) ->
    #     status = status
    #   )

    # else
    #   $http(
    #     url: "http://www.omdbapi.com/"
    #     method: "get"
    #     params: { i: movie.imdbID, plot: 'full' }
    #   ).success( (data, status, headers, config) ->
    #     console.log("data: " + data + "status: " + status + "headers:" + headers + "config: " + config + "imdbID: " + movie.imdbID)
    #     imdbInfo(data)
    #   ).error( (data, status, headers, config) ->
    #     status = status
    #   )

    # imdbInfo = (data) ->
    #   for key, info of data
    #     movieInfo[key] = info

  # infoFilter = (mInfo) ->
  #   if mInfo
  #     arr = {}
  #     for key, info of mInfo
  #       if key != 'Poster' && key != 'Title' && key != 'imdbID' && key != 'Response' && key != 'Release' && key != null
  #         if key == 'imdbRating' || key == 'imdbVotes' then key = (key[0..3].toUpperCase() + ' ' + key[4..-1])
  #         if key == 'Type' then info = info[0].toUpperCase()
  #         arr[key] = info
  #     arr