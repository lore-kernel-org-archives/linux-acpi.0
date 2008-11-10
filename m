From: "M. I. Veken" <miveken@gmail.com>
Subject: need help with buggy dsdt
Date: Mon, 10 Nov 2008 11:58:23 +0100
Message-ID: <491813CF.3070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:1789 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYKJK6y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 05:58:54 -0500
Received: by ug-out-1314.google.com with SMTP id 39so330670ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2008 02:58:53 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

i need help with my (buggy) dsdt:

i get these errors when trying to recompile (iasl -tc dsdt.dsl):
paste.ubuntu.com/69766/

here is my dsdt.dsl:
paste.ubuntu.com/69765/

thank you in advance for the help

PS sry for the links but i don't know how to manage that..
> it does not like your external referencies. remove them and you are down to 16 errors.
> proper externals could be acquired from SSDTs nearby... 

i don't understand that sry, could you explain please? why doesn't it like my links? what's that "down to 16 errors" 
about? what are SSDTs?
sry for my noobishness:|
