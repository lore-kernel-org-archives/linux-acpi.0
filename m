From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: kacpi_notify?
Date: Wed, 12 Jul 2006 15:23:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607121520150.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6F7630D@hdsmsx411.amr.corp.intel.com>
 <Pine.LNX.4.64.0607121509180.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:36999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750750AbWGLWXU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 18:23:20 -0400
In-Reply-To: <Pine.LNX.4.64.0607121509180.5623@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>



On Wed, 12 Jul 2006, Linus Torvalds wrote:
> 
> I'll try that. Right now I've started a "git bisect" run, since it seemed 
> to be the easiest way to get _some_ information about the problem, without 
> having to know much else about it.

Current result: it _looks_ like it was brought in by when I did the ACPI 
merge on June 23 (commit 37224470c8c6d90a4062e76a08d4dc1fcf91fc89).

I've got a hundred-odd commits to go, but the next bisection test happens 
to be the parent of my merge (your "merge linus into release branch" 
merge: ae6c859b7dcd708efadf1c76279c33db213e3506), so if I'm right, I'd 
expect that to be a bad tree.

		Linus
