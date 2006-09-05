From: Todd Pytel <tppytel@sophrosune.org>
Subject: Re: Hang on S3 resume with Acer TravelMate 222X
Date: Tue, 05 Sep 2006 01:48:32 -0500
Message-ID: <1157438912.19942.43.camel@timaeus.sophrosune.org>
References: <1157066944.1826.62.camel@timaeus.sophrosune.org>
	 <1157424745.19942.2.camel@timaeus.sophrosune.org>
	 <200609051428.32974.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aristotle.sophrosune.org ([66.167.100.107]:13128 "EHLO
	aristotle.sophrosune.org") by vger.kernel.org with ESMTP
	id S965182AbWIEGqb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 02:46:31 -0400
In-Reply-To: <200609051428.32974.luming.yu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2006-09-05 at 14:28 +0800, Yu Luming wrote:
> Not sure if this can help you. http://acpi.sourceforge.net/

I've checked out the site quite a bit - that's where I got a lot of the
DSDT info. But I didn't see anything specific to hard-locks on resume.

> Does windows work?

Of course. (Sadly...)

> If you think this is a ACPI bug , please file it on bugzilla.kernel.org in 
> ACPI category.

Well, I don't really know enough to say whether it's an ACPI bug or not.
>From what I've read, ACPI often needs a lot of troubleshooting because
the hardware and DSDT's don't follow the standard as strictly as
Linux-ACPI itself. If the regulars here think is a genuine Linux-ACPI
bug, then I can certainly file it.

> The first step, please take a close look at Documentation/power/video.txt

I've read it. But from what I understood, the various video tricks only
help after the kernel has resumed far enough to run processes. I'm not
getting that far. Maybe I'm not understanding...

Thank you for your suggestions.

--Todd

