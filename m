From: Matthieu Dubuget <matthieu.dubuget@gmail.com>
Subject: Re: [regression] suspend is flakey, "shutdown -h now" does not power
 off
Date: Mon, 29 Apr 2013 09:09:32 +0200
Message-ID: <517E1CAC.6090804@gmail.com>
References: <4EC27F88.9070209@gmail.com> <20111116044358.GB5889@elie.hsd1.il.comcast.net> <4EC95C07.6030706@gmail.com> <517BE0C6.4070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:56862 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab3D2HJf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2013 03:09:35 -0400
Received: by mail-ee0-f43.google.com with SMTP id b47so1524836eek.30
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2013 00:09:34 -0700 (PDT)
In-Reply-To: <517BE0C6.4070107@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>

It seems that the problem reported is not a regression in acpi, but a
bug in the amd64 version.  For all the live systems I tested, each
time I used a 386/686 version it worked fine, each time I tried a
amd64 version it failed.

Hoping this will help narrowing the bug!

 From now on, I'm not sure about what I could do to understand the
problem?

Maybe a kernel recompilation with some debugging options added? But
which?

Salutations, and thanks for your help

Matt


