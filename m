From: Luis Nabais <Luis.Nabais@caixamagica.pt>
Subject: Re: sony-laptop support for Vaio VGN-C2S
Date: Mon, 2 Mar 2009 19:32:09 +0000
Message-ID: <395cdfab0903021132lf1db308ofbd074a05c4817c9@mail.gmail.com>
References: <1235996539.4378.4.camel@dexmobile>
	 <20090302123948.GB24234@kamineko.org>
	 <395cdfab0903021129x8f2ed1dp9bd4ce165d29949d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd28ea6e77a24046427dfda
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:60161 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbZCBTcO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2009 14:32:14 -0500
Received: by fxm24 with SMTP id 24so2130990fxm.37
        for <linux-acpi@vger.kernel.org>; Mon, 02 Mar 2009 11:32:10 -0800 (PST)
In-Reply-To: <395cdfab0903021129x8f2ed1dp9bd4ce165d29949d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

--000e0cd28ea6e77a24046427dfda
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2009 at 7:29 PM, Luis Nabais <Luis.Nabais@caixamagica.pt> wr=
ote:
> On Mon, Mar 2, 2009 at 12:39 PM, Mattia Dongili <malattia@linux.it> wrote=
:
>> On Mon, Mar 02, 2009 at 12:22:19PM +0000, Luis Nabais wrote:
>>> I have a vaio VGN-C2S and some of the fn-keys (brightness and the
>>> monitor/tv-out key) don't work and since I don't know how to go and hac=
k
>>> the module to get the keys working I thought you could help me.
>>
>> what kernel version are you using?
>>
>
> 2.6.27.15-170.2.24.fc10.x86_64
> I'm using the standard fedora kernel cause I haven't had time to
> compile one lately, will do so as soon as possible.
>
>>> I attached the DSTD dump in this message.
>>
>> can you also send the output from
>> =C2=A0dmidecode -t system
>> and the kernel log after unloading and reloading the sony-laptop module
>> with
>> =C2=A0modprobe sony-laptop debug=3D1
>
> See attachment for dmesg output

Oops, forgot the attachment
>
>> also press some of non-working Fn keys and see if they show up in the
>> kernel log.
>
> I'm sorry to sound kind of n00bish but that would be dmesg right?
>
>>
>> thanks
>> --
>> mattia
>> :wq!
>>
>
>
>
> --
> www.nonsensebb.com
>



--=20
www.nonsensebb.com

--000e0cd28ea6e77a24046427dfda
Content-Type: text/plain; charset=US-ASCII; name="dmidecode.txt"
Content-Disposition: attachment; filename="dmidecode.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frtjrt5k1

IyBkbWlkZWNvZGUgMi45ClNNQklPUyAyLjQgcHJlc2VudC4KCkhhbmRsZSAweDAwMDEsIERNSSB0
eXBlIDEsIDI3IGJ5dGVzClN5c3RlbSBJbmZvcm1hdGlvbgoJTWFudWZhY3R1cmVyOiBTb255IENv
cnBvcmF0aW9uCglQcm9kdWN0IE5hbWU6IFZHTi1DMlNfSAoJVmVyc2lvbjogQzNMTlNLVDkKCVNl
cmlhbCBOdW1iZXI6IDI4MjAyOTYzLTUwMDAwNjcKCVVVSUQ6IEM2NzY3RUYwLUNDNjMtMTFEQi04
QTUxLTAwMTNBOUE1RTRGMQoJV2FrZS11cCBUeXBlOiBQb3dlciBTd2l0Y2gKCVNLVSBOdW1iZXI6
IE4vQQoJRmFtaWx5OiBOL0EKCkhhbmRsZSAweDAwMEYsIERNSSB0eXBlIDMyLCAyMCBieXRlcwpT
eXN0ZW0gQm9vdCBJbmZvcm1hdGlvbgoJU3RhdHVzOiBObyBlcnJvcnMgZGV0ZWN0ZWQKCg==
--000e0cd28ea6e77a24046427dfda
Content-Type: text/plain; charset=US-ASCII; name="dmesg_sony.txt"
Content-Disposition: attachment; filename="dmesg_sony.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frtjs0kn2

c29ueS1sYXB0b3A6IFNvbnkgTm90ZWJvb2sgQ29udHJvbCBEcml2ZXIgdjAuNi4Kc29ueS1sYXB0
b3A6IG1ldGhvZDogbmFtZTogX0lOSSwgYXJncyAwCnNvbnktbGFwdG9wOiBtZXRob2Q6IG5hbWU6
IEdCUlQsIGFyZ3MgMApzb255LWxhcHRvcDogbWV0aG9kOiBuYW1lOiBTQlJULCBhcmdzIDEKc29u
eS1sYXB0b3A6IG1ldGhvZDogbmFtZTogR1BCUiwgYXJncyAwCnNvbnktbGFwdG9wOiBtZXRob2Q6
IG5hbWU6IFNQQlIsIGFyZ3MgMQpzb255LWxhcHRvcDogbWV0aG9kOiBuYW1lOiBQV0FLLCBhcmdz
IDAKc29ueS1sYXB0b3A6IG1ldGhvZDogbmFtZTogR1dEUCwgYXJncyAwCnNvbnktbGFwdG9wOiBt
ZXRob2Q6IG5hbWU6IEdTTkUsIGFyZ3MgMQpzb255LWxhcHRvcDogbWV0aG9kOiBuYW1lOiBTU05F
LCBhcmdzIDEKc29ueS1sYXB0b3A6IG1ldGhvZDogbmFtZTogQ1NYQiwgYXJncyAxCnNvbnktbGFw
dG9wOiBtZXRob2Q6IG5hbWU6IFNPRFYsIGFyZ3MgMQpzb255LWxhcHRvcDogbWV0aG9kOiBuYW1l
OiBHRERJLCBhcmdzIDAKc29ueS1sYXB0b3A6IG1ldGhvZDogbmFtZTogU1RDUywgYXJncyAxCnNv
bnktbGFwdG9wOiBtZXRob2Q6IG5hbWU6IFJCTUYsIGFyZ3MgMQpzb255LWxhcHRvcDogbWV0aG9k
OiBuYW1lOiBSU0JJLCBhcmdzIDEKc29ueS1sYXB0b3A6IG1ldGhvZDogbmFtZTogQ0JNRiwgYXJn
cyAxCnNvbnktbGFwdG9wOiBtZXRob2Q6IG5hbWU6IFNOMDAsIGFyZ3MgMQpzb255LWxhcHRvcDog
bWV0aG9kOiBuYW1lOiBTTjAxLCBhcmdzIDAKc29ueS1sYXB0b3A6IG1ldGhvZDogbmFtZTogU04w
MiwgYXJncyAxCnNvbnktbGFwdG9wOiBtZXRob2Q6IG5hbWU6IFNOMDMsIGFyZ3MgMQpzb255LWxh
cHRvcDogbWV0aG9kOiBuYW1lOiBTTjA0LCBhcmdzIDAKc29ueS1sYXB0b3A6IG1ldGhvZDogbmFt
ZTogU04wNSwgYXJncyAxCnNvbnktbGFwdG9wOiBtZXRob2Q6IG5hbWU6IFNOMDYsIGFyZ3MgMQpz
b255LWxhcHRvcDogbWV0aG9kOiBuYW1lOiBTTkNNLCBhcmdzIDAKc29ueS1sYXB0b3A6IG1ldGhv
ZDogbmFtZTogU04wNywgYXJncyAxCnNvbnktbGFwdG9wOiBtZXRob2Q6IG5hbWU6IFNORjAsIGFy
Z3MgMQpzb255LWxhcHRvcDogbWV0aG9kOiBuYW1lOiBTTkYxLCBhcmdzIDEKc29ueS1sYXB0b3A6
IG1ldGhvZDogbmFtZTogU05GMiwgYXJncyAxCnNvbnktbGFwdG9wOiBtZXRob2Q6IG5hbWU6IFNO
RjMsIGFyZ3MgMQpzb255LWxhcHRvcDogbWV0aG9kOiBuYW1lOiBTTkY0LCBhcmdzIDEKc29ueS1s
YXB0b3A6IG1ldGhvZDogbmFtZTogU05GNywgYXJncyAxCnNvbnktbGFwdG9wOiBtZXRob2Q6IG5h
bWU6IFNORkUsIGFyZ3MgMQpzb255LWxhcHRvcDogbWV0aG9kOiBuYW1lOiBTTkZGLCBhcmdzIDEK
c29ueS1sYXB0b3A6IG1ldGhvZDogbmFtZTogU05BViwgYXJncyAwCnNvbnktbGFwdG9wOiBtZXRo
b2Q6IG5hbWU6IFNOR04sIGFyZ3MgMQpzb255LWxhcHRvcDogSW52b2tpbmcgX0lOSQpzb255LWxh
cHRvcDogZGV0ZWN0ZWQgU29ueSBWYWlvIEMgU2VyaWVzCnNvbnktbGFwdG9wOiBGb3VuZCBicmln
aHRuZXNzX2RlZmF1bHQgZ2V0dGVyOiBHUEJSCnNvbnktbGFwdG9wOiBGb3VuZCBicmlnaHRuZXNz
X2RlZmF1bHQgc2V0dGVyOiBTUEJSCg==
--000e0cd28ea6e77a24046427dfda--
