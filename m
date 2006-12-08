From: Miroslav Ruda <ruda@ics.muni.cz>
Subject: Re: suspend to RAM on lifebook 7110
Date: Fri, 8 Dec 2006 22:13:08 +0100
Message-ID: <20061208211308.GA5157@erebor.ics.muni.cz>
References: <20061208123358.GA3724@invalid.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:42228 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947246AbWLHVNL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2006 16:13:11 -0500
Content-Disposition: inline
In-Reply-To: <20061208123358.GA3724@invalid.invalid>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: seife@suse.de

On Fri, Dec 08, 2006 at 01:33:58PM +0100, Frank Ursel wrote:
> Before i actually suspend the notebook, i write some data about the
> graphic card on disk and on resume the data is written back to the
> graphic card and everything works fine (I'm writing only the relevant
> parts in here):
> 
>  # discover video card's ID
>  ID=`lspci | grep VGA | awk '{ print $1 }' | sed -e 's@0000:@@' -e 's@:@/@'`
> 
>  # dump current data from the video card to the temporary file
>  cat /proc/bus/pci/$ID > $TMP_FILE
> 
>  # suspend
>  echo -n mem > /sys/power/state
> 
>  # restore video card data from the temporary file
>  # on resume
>  cat $TMP_FILE > /proc/bus/pci/$ID

Great, it works for me too.

> Note: This works fine for me in a script, which is invoked by acpi on
>       button-press. I'm using Debian/SID and i don't know where the right
>       place for manipulation on Suse is. Maybe you need to tweek a bit

Just for record (or others with the same problem :-), I'm using hibernate 
script from swsusp2 and there I was able to use
OnSuspend 80 /etc/hibernate/video.sh store
OnResume 80 /etc/hibernate/video.sh restore
into /etc/hibernate/ususpend-ram.conf script.

Or on Suse 10.2, pm-utils are used by default and it's easy to add call to 
this script to /etc/pm/hooks/ directory.

Thanks for your help.

-- 
                  Mirek Ruda 
