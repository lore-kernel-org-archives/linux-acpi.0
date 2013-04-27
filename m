From: Matthieu Dubuget <matthieu.dubuget@gmail.com>
Subject: Re: [regression] suspend is flakey, "shutdown -h now" does not power
 off
Date: Sat, 27 Apr 2013 16:43:46 +0200
Message-ID: <517BE422.3040408@gmail.com>
References: <4EC27F88.9070209@gmail.com> <4EC95C07.6030706@gmail.com> <517BE0C6.4070107@gmail.com> <2675056.KHaN45LQTO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:48520 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab3D0Ont (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Apr 2013 10:43:49 -0400
Received: by mail-wi0-f169.google.com with SMTP id h11so1667344wiv.0
        for <linux-acpi@vger.kernel.org>; Sat, 27 Apr 2013 07:43:47 -0700 (PDT)
In-Reply-To: <2675056.KHaN45LQTO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>


Le 27/04/2013 16:42, Rafael J. Wysocki a =C3=A9crit :
>
>  What's the newest kernel you tried?
>
>  Rafael
>
>

Hello Rafael,

It used to worked when I bought the computer. And I can check this
with a live CD:

* Ubuntu 2.6.32.41+drm33.18 (started from the Ubuntu 10.04.3 LTS live
   CD)

Since then, I tried:

* Debian 3.0.0-6 (which is very close to upstream stable v3.0.8)
* Debian 3.1.0-1~experimental.1 (which is basically linus's v3.1)
* Debian 2.6.32-39 (close to longterm v2.6.32.43)
* Ubuntu 3.0.0-12.20-generic (3.0.4 ? started from the Ubuntu live CD)

* And this morning, I downloaded, compiled and ran 3.8.10 from
   kernel.org without more success.

Salutations

Matt




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
