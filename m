From: Luca Capello <luca@pca.it>
Subject: `cat /sys/device/platform/dock.0/uevent` oops
Date: Sat, 15 Sep 2007 17:57:03 +0200
Message-ID: <87642bc46o.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_YXvTLU17u/qTvbWEN5Bp+A)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mbox.unige.ch ([129.194.9.209]:62394 "EHLO mbox.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbXIOQ5N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Sep 2007 12:57:13 -0400
Received: from gismo.pca.it ([151.16.11.125])
 by mbox.unige.ch (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9
 2007; 32bit)) with ESMTPSA id <0JOF00A7H2Z9I100@mbox.unige.ch> for
 linux-acpi@vger.kernel.org; Sat, 15 Sep 2007 17:57:10 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ML Linux-ACPI <linux-acpi@vger.kernel.org>


--Boundary_(ID_YXvTLU17u/qTvbWEN5Bp+A)
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT

Hello!

this happens after a `cat /sys/devices/platform/dock.0/uevent` on two
differently built Debian 2.6.23-rc5-amd64 and on a vanilla 2.6.23-rc5.

My machine is an IBM/Lenovo ThinkPad X60 [1], BIOS 7BETD0WW (2.11),
Debian sid up-to-date.  The docking station is model 40Y8116 (FRU P/N
42W3070).

Thx, bye,
Gismo / Luca

Footnotes: 
[1] http://luca.pca.it/projects/ibm/x60_1706-gmg/


--Boundary_(ID_YXvTLU17u/qTvbWEN5Bp+A)
Content-type: application/octet-stream; NAME=dock-uevent_2.6.23-rc5.oops.gz
Content-transfer-encoding: base64
Content-disposition: attachment; filename=dock-uevent_2.6.23-rc5.oops.gz
Content-description: oops when `cat /sys/device/platform/dock.0/uevent`

H4sICLP860YAA2RvY2stdWV2ZW50XzIuNi4yMy1yYzUub29wcwDNmG2P4rYWx9/vpzhS37S63a2d
56Bqpd2ZdrXq02joSldqq8ixHXCHPDQxMPPt73ECAQJkDOJKRRrIGPt/jn3s48NvKiugDhA6IdGE
xLAoOVvMy0bDKl8W6nkCH+4ePk/gz2T6MXn36f7uJ3gLouRPqpi9mb46eNmk4L8NJlDINczVbA5N
JaWAL9OPIORKcYldUArknKtkzgWwAv+EqGXTQHCJBV4WmZota6ZVWcBXFDj2kwVkdZlD+x9asxCc
LztB+o5MWj9NQ1YuC3HpYA+qstYNTlRLruVgvOucGP+lYOlCgi5hjguBT0+yLuQCKjYzq1TLf5YS
uzMNpH155s2JiCDw+PlhAhYm4I/vs80rIi4hjIr3f0Gj62Ihi/+QZ0q/wzdmofTw6R7CkDsOCUJ4
+HIPxMb+b2XVTFr34Q/6F0x/ebAZdffwBYNo0fGXUiwXsoGFKp5wo6kCg4Jby2wT3CGaqULWoGLq
g6hzqDNe5jksHM4qSBdLqctSz9sNDqpaBcB4pRJeLTNceth8JijUyHqFO20l+8ayEDI3u3fbUJVr
WTdsr8sSRzUV47uWRjPcIO2jbiOfYR9YqqJaashULdf4lzRpZaZaVlDxnCsGrOa4uZR6BslTaAqR
zAVLVKFxq6ha65ekUTXMJM5VcVBCosu1BGxM8NTthEtcGlC/3/2WrIVuddBAUuLRM8+5epZ1+18/
oJVR64Ubez40wgzPc75R74YDr3mi9DLR8CJxwZMGF1NqqBtsL3DlcMroVDeTbiTK52tm5BdsY1ur
HOOUMq1l/QIrnEIJ5VKbZWEccsYj4lBquoJy0F5EaPvQeYLTLpOarfGgsGS7DH2KSZdaY4pQtWCt
s5wrrUFSsyV5NuuUqyYv21hsR+nGLF1jEsFuumwmE7bAXQjt4idsVoFcmY5/ly/mQz5rF/5OBeQp
Z3yOw+bM8XFf4RblKcc998RVNce5ijzh9UulzUOu6rpsm5qCVc287FpLgWvefmgckTPMC3XJMVNi
34wVwEw8FgpXjUHDG2W62pxjJSYQBVH4LZjTgKkU88uvaNOcFsxb4LwL3jnu25r7b1kuAg+zq4Vs
m5AIoWRyMuPcLg89TjtD0aQVwzi6rpul3CcAP/z484dP0zbfUOLEoY3ch/9OTqTXj9h6qJ9G8Hi3
ae2m4UVBylIbG/dHahLVpp93apuXxL6fj/2xsfHxYWcj4LGUxOXwiN03aoRsjWBrPPBH+JGNDYxu
r7Z9YSs9aqXY6lw3D+qe8ph6Jy37u3nIbs428fgRt0ir5jAMaxRkTiDJ16bhG8Dts1UklPou97bf
PBUL/HLohM1t1pmjBO6nm7vwh+3D3ePekkaE+MRuCnePJ5YXW/cWzwvTOOpsDBcvYDZ+3z+eCvf9
43G4Tatz3Gplwz2pFhxuAnwzreGgr2dl46FLm22i+7rapT89ryUTqsjKg8PAUBi/ZM1T3xyKOE1x
Lb+xsDbVjD9hwPfTHeUh3dkIKHMx0Hs9nNhxHNnPLdx8YVPfHR35YX4aHHTcJYeL7fKLzEiaShOi
fmmYcEIiycCRvR6t3cy3Oil4u8LvNdZMk8trW7PIeKesmqKq8SbL8FZxXQ+vFT+2SW4Hal1AUC1J
TGmJV7+eJ2u2eEJR7gkUFbHNZTt0ETONufZ6B33a+nexUsA8FqJStWA6K+s8WcoVll+o6Dio6ASX
K4YeiVARy5g9MZGimuu5l8sFbpSaqc7L9U6Pm5XDm/nicASxK8x8Z1J3ZZj5nYdvUi5UY5Rd0Uba
apcdSnNOuqC8NFmTYMmZMG5K/USvSxSWtnXJ0OEgjdr90xaMrdONCXhswpPapPiBm6kbZb2bJnEl
mVpIlIy5cZFevqhRHFAjudoImgCZeOOtd4UWZsjOva2W56NWIC+WIqkMZCelJZbJuICoFppARDaO
3abLXSkkXhQE3AgTJoQ+yAy8CJwYsgi4Cy4FTkCmRsejphuPIPSAMNMNaxa7ovmGlbEpjeH7g7SL
VfH7a6uJvXFY9+FPaCtahD+YjnjRueE9zWkBkWrwl3Yhuf52Dwm96WXcietPaPD/xCjnTVwapPNK
BqM40kvTExjl/KgxjHJ+1ACjnO94AqNYQZM9xvIvxCctCUETwjDBFqIYftKClA1Z2dGTLSwZ0JUN
+9iSifPMpKMjA7SxZRFbVtKDjJ7R9DTmENIcEhjGD9lKjzZ6GNPDjY7EjMCXjntsmMgOveyTk4rV
hmSix9vHPW6ygy09O+mJTA9PejSzxSo7XGIQzlmq0kGXA6Ki57glK7zszN6CYlWz/F9EWUaOufmZ
EdAovoaynJe9MWUZMXREWRyZSjpOWUbkXqcsnf6rlGXExv2R2pWUZcTGPmVxJAt8S8rS+rNPWUZs
3IyyjNm4krKwbs428dhRltSJhS8degPKMnLZXU1ZRjRfpyyO5FSS05RF2vh9O8oyZuNWlGUk4x1R
li79naAs5jAY4QFlcWQQe1G0R1nOW3uVsoRhKqLLKMtI+Xd05If5aXDQxyiLnRkekAOG4qcCmwaO
EHJod5+yjOzqE5TFuvS1oiyWapdRFnsXX6Mstkr2lMVa0Y6yWMvZURbbcFxBWWylL6Ms9g5bUhZr
N+0pi62kDWWx13qVsthK2VGW82q36XJDyjJaNN+wMj6kLNuq+P211cSb/wF3RjudlCMAAA==

--Boundary_(ID_YXvTLU17u/qTvbWEN5Bp+A)--
