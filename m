From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.28-rc1: rapid hotkeys break on eeepc again :(
Date: Wed, 29 Oct 2008 03:03:34 +0300
Message-ID: <4907A856.3050204@gmail.com>
References: <4907A511.3040603@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:36092 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYJ2ADi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 20:03:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1117880nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2008 17:03:37 -0700 (PDT)
In-Reply-To: <4907A511.3040603@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Please check if changing msleep to udelay helps.
Alan Jenkins wrote:
> Similar but different to the original symptoms of bugzilla #11089 (which
> is closed, fixed by the specific patch I tested).  Hotkeys give up the
> ghost after being held down for a while, or pressed rapidly.  However
> they don't get "out of sync" as in that bug.  I've already tried the
> acpi-test tree, but that didn't fix it.
>
> Bad: v2.6.28-rc1
> Good: v2.6.27-89-g3156d1e
>
> I can't see any non-trivial changes to the EC or eeepc-laptop drivers in
> that range, so it looks like I have to do this the hard way.
>
> Bisecting: 3857 revisions left to test after this
>
> Ow.
>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

