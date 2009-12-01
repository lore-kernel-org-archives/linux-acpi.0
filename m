From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: Kernel BUG during suspend to disk with 2.6.32-rc8-git3
Date: Tue, 01 Dec 2009 15:50:22 -0800
Message-ID: <4B15ABBE.90101@gmail.com>
References: <4B159EAC.1010006@lwfinger.net> <4B15A2F6.4020206@gmail.com> <4B15A9FB.2030808@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36306 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbZLAXuR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2009 18:50:17 -0500
In-Reply-To: <4B15A9FB.2030808@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On 12/01/09 15:42, Larry Finger wrote:
> On 12/01/2009 05:12 PM, Justin P. Mattock wrote:
>>
>>
>> looks familiar with what I'm getting
>> over here.
>> bugreport: http://bugzilla.kernel.org/show_bug.cgi?id= 14483
>>
>> at the bottom reverting that commit
>> worked here(but still need to see
>> what others say).
>
> Reverting commit 138d15692bf76841f252d4b836a535cf5f9154e9 fixed the
> problem on my computer. Thanks for the info.
>
> Larry
>
>

cool,
finally some kind of handle
on this. Now I guess the
best thing todo now is to
wait and see what the acpi guys have
to say.

Justin P. Mattock

