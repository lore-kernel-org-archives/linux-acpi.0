From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Switching controller mode in software?
Date: Thu, 26 Jul 2007 08:03:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707250911450.21897@butterbrot.org>
References: <1184659806.15435.4.camel@pancake>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="425018882-665012079-1185347827=:21897"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charlie109.server4you.de ([85.25.2.70]:53399 "EHLO
	butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbXGZG2Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 02:28:16 -0400
In-Reply-To: <1184659806.15435.4.camel@pancake>
Content-ID: <Pine.LNX.4.64.0707260803100.23945@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi@linux.intel.com, linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--425018882-665012079-1185347827=:21897
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-ID: <Pine.LNX.4.64.0707250918121.21897@butterbrot.org>

> I have a notebook (Acer Aspire 5550) with the Intel ICH7 chipset (see 
> attached lspci output). Unfortunately, the SATA controller is stuck in 
> non-AHCI mode and the braindead BIOS doesn't allow me to change that. Is 
> it possible to change the controller to AHCI mode in software, e.g. 
> through ACPI?
Unfortunately, nobody on linux-ide seemed to have an answer for this 
so far. Therefore, I am hoping that some of you ACPI guys can probably 
help me out..

Yours, Florian
-- 
"_Nothing_ brightens up my morning. Coffee simply provides a shade of
grey just above the pitch-black of the infinite depths of the _abyss_."
--425018882-665012079-1185347827=:21897
Content-Type: TEXT/PLAIN; charset=us-ascii; name=tmp
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0707250917070.21897@butterbrot.org>
Content-Description: 
Content-Disposition: attachment; filename=tmp

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gTW9iaWxl
IDk0NUdNL1BNL0dNUy85NDBHTUwgYW5kIDk0NUdUIEV4cHJlc3MgTWVtb3J5
IENvbnRyb2xsZXIgSHViIChyZXYgMDMpDQowMDowMS4wIFBDSSBicmlkZ2U6
IEludGVsIENvcnBvcmF0aW9uIE1vYmlsZSA5NDVHTS9QTS9HTVMvOTQwR01M
IGFuZCA5NDVHVCBFeHByZXNzIFBDSSBFeHByZXNzIFJvb3QgUG9ydCAocmV2
IDAzKQ0KMDA6MWIuMCBBdWRpbyBkZXZpY2U6IEludGVsIENvcnBvcmF0aW9u
IDgyODAxRyAoSUNINyBGYW1pbHkpIEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBD
b250cm9sbGVyIChyZXYgMDIpDQowMDoxYy4wIFBDSSBicmlkZ2U6IEludGVs
IENvcnBvcmF0aW9uIDgyODAxRyAoSUNINyBGYW1pbHkpIFBDSSBFeHByZXNz
IFBvcnQgMSAocmV2IDAyKQ0KMDA6MWMuMSBQQ0kgYnJpZGdlOiBJbnRlbCBD
b3Jwb3JhdGlvbiA4MjgwMUcgKElDSDcgRmFtaWx5KSBQQ0kgRXhwcmVzcyBQ
b3J0IDIgKHJldiAwMikNCjAwOjFjLjIgUENJIGJyaWRnZTogSW50ZWwgQ29y
cG9yYXRpb24gODI4MDFHIChJQ0g3IEZhbWlseSkgUENJIEV4cHJlc3MgUG9y
dCAzIChyZXYgMDIpDQowMDoxZC4wIFVTQiBDb250cm9sbGVyOiBJbnRlbCBD
b3Jwb3JhdGlvbiA4MjgwMUcgKElDSDcgRmFtaWx5KSBVU0IgVUhDSSAjMSAo
cmV2IDAyKQ0KMDA6MWQuMSBVU0IgQ29udHJvbGxlcjogSW50ZWwgQ29ycG9y
YXRpb24gODI4MDFHIChJQ0g3IEZhbWlseSkgVVNCIFVIQ0kgIzIgKHJldiAw
MikNCjAwOjFkLjIgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9u
IDgyODAxRyAoSUNINyBGYW1pbHkpIFVTQiBVSENJICMzIChyZXYgMDIpDQow
MDoxZC4zIFVTQiBDb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4Mjgw
MUcgKElDSDcgRmFtaWx5KSBVU0IgVUhDSSAjNCAocmV2IDAyKQ0KMDA6MWQu
NyBVU0IgQ29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gODI4MDFHIChJ
Q0g3IEZhbWlseSkgVVNCMiBFSENJIENvbnRyb2xsZXIgKHJldiAwMikNCjAw
OjFlLjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDEgTW9i
aWxlIFBDSSBCcmlkZ2UgKHJldiBlMikNCjAwOjFmLjAgSVNBIGJyaWRnZTog
SW50ZWwgQ29ycG9yYXRpb24gODI4MDFHQk0gKElDSDctTSkgTFBDIEludGVy
ZmFjZSBCcmlkZ2UgKHJldiAwMikNCjAwOjFmLjIgSURFIGludGVyZmFjZTog
SW50ZWwgQ29ycG9yYXRpb24gODI4MDFHQk0vR0hNIChJQ0g3IEZhbWlseSkg
U2VyaWFsIEFUQSBTdG9yYWdlIENvbnRyb2xsZXIgSURFIChyZXYgMDIpDQow
MDoxZi4zIFNNQnVzOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUcgKElDSDcg
RmFtaWx5KSBTTUJ1cyBDb250cm9sbGVyIChyZXYgMDIpDQowMTowMC4wIFZH
QSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEFUSSBUZWNobm9sb2dpZXMgSW5j
IE01MiBbQVRJIE1vYmlsaXR5IFJhZGVvbiBYMTMwMF0NCjAzOjAwLjAgTmV0
d29yayBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBQUk8vV2lyZWxl
c3MgMzk0NUFCRyBOZXR3b3JrIENvbm5lY3Rpb24gKHJldiAwMikNCjBhOjAx
LjAgQ2xhc3MgMDgwNTogUmljb2ggQ28gTHRkIFI1QzgyMiBTRC9TRElPL01N
Qy9NUy9NU1BybyBIb3N0IEFkYXB0ZXIgKHJldiAxOSkNCjBhOjAxLjEgU3lz
dGVtIHBlcmlwaGVyYWw6IFJpY29oIENvIEx0ZCBVbmtub3duIGRldmljZSAw
ODQzIChyZXYgMDEpDQowYTowMS4yIFN5c3RlbSBwZXJpcGhlcmFsOiBSaWNv
aCBDbyBMdGQgUjVDNTkyIE1lbW9yeSBTdGljayBCdXMgSG9zdCBBZGFwdGVy
IChyZXYgMGEpDQowYTowMS4zIFN5c3RlbSBwZXJpcGhlcmFsOiBSaWNvaCBD
byBMdGQgeEQtUGljdHVyZSBDYXJkIENvbnRyb2xsZXIgKHJldiAwNSkNCjBh
OjA3LjAgRXRoZXJuZXQgY29udHJvbGxlcjogUmVhbHRlayBTZW1pY29uZHVj
dG9yIENvLiwgTHRkLiBSVEwtODEzOS84MTM5Qy84MTM5QysgKHJldiAxMCkN
CjBhOjA5LjAgQ2FyZEJ1cyBicmlkZ2U6IEVORSBUZWNobm9sb2d5IEluYyBD
QjE0MTAgQ2FyZGJ1cyBDb250cm9sbGVyIChyZXYgMDEpDQo=

--425018882-665012079-1185347827=:21897--
