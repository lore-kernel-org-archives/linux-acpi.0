From: Norbert Preining <preining@logic.at>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Thu, 23 Apr 2009 18:46:42 +0200
Message-ID: <20090423164642.GF495@gamma.logic.tuwien.ac.at>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:49880 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZDWQzx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 12:55:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, rui.zhang@intel.com, Keith Packard <keithp@keithp.com>, linux-acpi@vger.kernel.org

On Do, 23 Apr 2009, Len Brown wrote:
> I thought we had addressed this, no?

The last I have seen are the two patches by  Zhao Yakui in the emails
subject: 
	ACPI: Weaken the dependency between ACPI video driver and I915
and
	ACPI: Check whether the acpi video is deferrable only when KMS is enabled

> CONFIG_DRM_I915=y
> CONFIG_ACPI_VIDEO=m
> 
> drivers/built-in.o: In function `intel_opregion_init':
> (.text+0x9d540): undefined reference to `acpi_video_register'

For me these two patches fix the problem.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
FRATING GREEN (adj.)
The shade of green which is supposed to make you feel comfortable in
hospitals, industrious in schools and uneasy in police stations.
			--- Douglas Adams, The Meaning of Liff
