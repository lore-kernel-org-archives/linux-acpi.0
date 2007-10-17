From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Fix to "All wake-up devices are disabled after suspend-to disk" isn't yet included in mainline
Date: Wed, 17 Oct 2007 06:27:26 +0200
Message-ID: <200710170627.26136.maximlevitsky@gmail.com>
References: <200710170439.30359.maximlevitsky@gmail.com> <20071016204802.9036ad96.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.238]:23929 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXJQE16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Oct 2007 00:27:58 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1806206hue
        for <linux-acpi@vger.kernel.org>; Tue, 16 Oct 2007 21:27:56 -0700 (PDT)
In-Reply-To: <20071016204802.9036ad96.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wednesday 17 October 2007 05:48:02 Andrew Morton wrote:
> On Wed, 17 Oct 2007 04:39:30 +0200 Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> 
> > A while ago I asked on LKML about the problem of loosing all wake device capabilities, after a suspend to disk
> > (eg: I can't wake the system from keyboard if I suspend to disk and then to ram)
> > 
> > I was provided with the patch that fixes this problem completely.
> > The merge window is open, but I still don't see it in the kernel.
> > Due to changes it doesn't anymore apply to latest git.
> > 
> > Was it missed?
> 
> No, it's in Len's git tree.
> 
> Len's git-pull request from a few days ago didn't work, perhaps because I
> wanted to know if a recent -mm regression had been fixed and that hasn't
> been answered yet.  I assume that Len is offline.  Other acpi developers
> could presumably have answered that question but for some reason chose not to.
> 
> I'm presently holding off 20-odd power management patches due to their
> dependency upon an acpi merge...
> 


Thanks a lot.
	Best regards,
		Maxim Levitsky
