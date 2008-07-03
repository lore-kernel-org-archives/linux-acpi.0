From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 55/84] ACPI: video: fix brightness allocation
Date: Thu, 3 Jul 2008 13:56:55 +0200
Message-ID: <200807031356.56784.trenn@suse.de>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org> <985af41a38b76827c1f0692cf18469ebf0c4475b.1214631214.git.len.brown@intel.com> <200807021857.45814.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56873 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085AbYGCL5A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Jul 2008 07:57:00 -0400
In-Reply-To: <200807021857.45814.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, Len Brown <len.brown@intel.com>, ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On Wednesday 02 July 2008 18:57:44 Thomas Renninger wrote:
> On Saturday 28 June 2008 07:43:59 Len Brown wrote:
> > From: Julia Jomantaite <julia.jomantaite@gmail.com>
> >
> > Fix use of uninitialized device->brightness.
>
> Can this one be left out.
It's fine. I go on top. It has what I need and already got reviewed.
I will try to post my things later today.

Sorry for the noise.

   Thomas
