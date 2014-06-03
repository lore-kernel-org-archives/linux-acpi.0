From: Jeremie Tamburini <jeremie.tamburini@gmail.com>
Subject: Re: BUG REPORT backlight acpi: Brightness shortcuts don't work on
 Fujitsu
Date: Tue, 03 Jun 2014 11:13:24 +0200
Message-ID: <538D91B4.7050209@gmail.com>
References: <538D7845.9010305@gmail.com> <538D80C4.5080901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64705 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbaFCJN2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jun 2014 05:13:28 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so6119116wiv.13
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jun 2014 02:13:27 -0700 (PDT)
In-Reply-To: <538D80C4.5080901@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

Il 03/06/2014 10:01, Aaron Lu ha scritto:
> On 06/03/2014 03:24 PM, Jeremie Tamburini wrote:
>>
>> On Fujitsu Lifebook A512 pressing Fn+F6 or Fn+F7 the brightness doesn't
>> change.
>
> Sounds like the notification isn't sent on hotkey press.
> Please attach your acpidump:
> # acpidump > acpidump.txt
> either to your original bug report or create a new one at:
> https://bugzilla.kernel.org under category ACPI/Power-Video.

In some ways the system is able to understand that I'm pressing 
Fn+F6/Fn+F7. The pop-up indicator (this one 
http://s1.postimg.org/dly8ordov/Brightness.png) is showing the 
brightness level adjustment. Unfortunately the brightness itself doesn't 
change.

Here is the acpidump.txt: 
https://launchpadlibrarian.net/176842546/acpidump.txt

Best regards
Jeremie
