From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: acer aspire 5315, Ubuntu 2.6.22-14-generic, kernel says send dmidecode, acpi not working correctly
Date: Mon, 28 Jan 2008 10:51:06 +0000
Message-ID: <200801281051.06687.carlos@strangeworlds.co.uk>
References: <de8605510801271842pc2a690dnd603c6b9faad88ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:32907 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbYA1KvJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jan 2008 05:51:09 -0500
In-Reply-To: <de8605510801271842pc2a690dnd603c6b9faad88ec@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ibiltari <ibiltari@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Monday 28 January 2008 02:42:07 Ibiltari wrote:
> Hi, cpu throtling is not aparently recognised and lots of "APIC error
> on CPU0: 40(40)" messages.
>
> Hope it helps, thanks for your work!!

http://bugzilla.kernel.org/show_bug.cgi?id=6404

There were also a thread on LKML about this (as it happens on various 
chipsets - including the ATI one in my Aspire 5020). Last I read though, 
no-one really had much idea what was causing this to trigger.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
