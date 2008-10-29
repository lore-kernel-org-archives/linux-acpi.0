From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: 2.6.28-rc1: rapid hotkeys break on eeepc again :(
Date: Wed, 29 Oct 2008 17:12:55 +0300
Message-ID: <49086F67.1030607@suse.de>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com> <4908307C.8060503@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:59776 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752412AbYJ2OM5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 10:12:57 -0400
In-Reply-To: <4908307C.8060503@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
>> Please check if changing msleep to udelay helps.
>> Alan Jenkins wrote:
>>> Similar but different to the original symptoms of bugzilla #11089 (which
>>> is closed, fixed by the specific patch I tested).  Hotkeys give up the
>>> ghost after being held down for a while, or pressed rapidly.  However
>>> they don't get "out of sync" as in that bug.  I've already tried the
>>> acpi-test tree, but that didn't fix it.
> That was in acpi-test, unless I misread the changelog.  It's the main
> reason I tried that, I should have mentioned it, sorry.   So no, it
> didn't help.
Any luck with bisect? 
