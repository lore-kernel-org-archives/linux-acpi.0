From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: 2.6.28-rc1: rapid hotkeys break on eeepc again :(
Date: Wed, 29 Oct 2008 09:44:28 +0000
Message-ID: <4908307C.8060503@tuffmail.co.uk>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:44282 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbYJ2Joe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 05:44:34 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1208040nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2008 02:44:32 -0700 (PDT)
In-Reply-To: <4907A856.3050204@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Alexey Starikovskiy wrote:
> Please check if changing msleep to udelay helps.
> Alan Jenkins wrote:
>> Similar but different to the original symptoms of bugzilla #11089 (which
>> is closed, fixed by the specific patch I tested).  Hotkeys give up the
>> ghost after being held down for a while, or pressed rapidly.  However
>> they don't get "out of sync" as in that bug.  I've already tried the
>> acpi-test tree, but that didn't fix it.
That was in acpi-test, unless I misread the changelog.  It's the main
reason I tried that, I should have mentioned it, sorry.   So no, it
didn't help.

Thanks
Alan
