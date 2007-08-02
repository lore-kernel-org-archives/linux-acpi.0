From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: scripts/mod/file2alias.c cross compile problem
Date: Thu, 2 Aug 2007 20:39:03 +0100
Message-ID: <20070802193903.GN21089@ftp.linux.org.uk>
References: <jewswdvqpt.fsf@sykes.suse.de> <617E1C2C70743745A92448908E030B2A02156CC1@scsmsx411.amr.corp.intel.com> <20070802180903.GD2431@uranus.ravnborg.org> <20070802191509.GX3972@stusta.de> <20070802192456.GA3509@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37512 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246AbXHBTjT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Aug 2007 15:39:19 -0400
Content-Disposition: inline
In-Reply-To: <20070802192456.GA3509@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, "Luck, Tony" <tony.luck@intel.com>, Andreas Schwab <schwab@suse.de>, trenn@suse.de, Jan Dittmer <jdi@l4x.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, rusty@rustcorp.com.au, jcm@jonmasters.org

On Thu, Aug 02, 2007 at 09:24:56PM +0200, Sam Ravnborg wrote:
> I am well aware of that.
> My point was that we are dealing with userspace - in this case depmod.
> So I wondered why we had special (as in less strict) rules here.

In reality it's a pointer...
