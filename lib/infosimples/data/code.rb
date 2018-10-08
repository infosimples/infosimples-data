module Infosimples::Data
  CODE = {
    # success
    single_result:          200,
    multiple_results:       201,

    # error
    unexpected_error:       600,
    unauthorized:           601,
    invalid_service:        602,
    forbidden:              603,
    invalid_request:        604,
    timeout:                605,
    empty_parameters:       606,
    invalid_parameters:     607,
    refused_parameters:     608,
    attempts_exceeded:      609,
    failed_captcha:         610,
    incomplete_data:        611,
    inexistent:             612,
    blocked_request:        613,
    try_again:              614,
    source_unavailable:     615,
    source_error:           616,
    service_overloaded:     617,
    rate_limit_exceeded:    618,
    converted_parameters:   619,
    permanent_error:        620,
    receipt_error:          621,
  }
end
