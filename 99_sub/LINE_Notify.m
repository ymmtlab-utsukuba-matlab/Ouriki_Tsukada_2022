function status_code = LINE_Notify(token, msg)
% input->token: YOUR access token for LINE Notify
%        msg: your message
    url = "https://notify-api.line.me/api/notify";
    opt = weboptions('HeaderFields', {'Authorization', ['Bearer ', token]});
    response = webwrite(url, 'message', msg, opt);
    status_code = response.status;
end