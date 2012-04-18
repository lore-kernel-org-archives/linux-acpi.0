From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] x86/acpi: Call acpi_enter_sleep_state via an asmlinkage C function from assembler.
Date: Wed, 18 Apr 2012 23:02:51 +0200
Message-ID: <201204182302.51868.rjw@sisk.pl>
References: <1334769518-7660-1-git-send-email-konrad.wilk@oracle.com> <1334769518-7660-3-git-send-email-konrad.wilk@oracle.com> <4F8F28BF.6010003@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51574 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab2DRU6P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2012 16:58:15 -0400
In-Reply-To: <4F8F28BF.6010003@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, ming.m.lin@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, "Brown, Len" <len.brown@intel.com>

On Wednesday, April 18, 2012, H. Peter Anvin wrote:
> On 04/18/2012 10:18 AM, Konrad Rzeszutek Wilk wrote:
> > 
> > Suggested-by: H. Peter Anvin <hpa@zytor.com>
> > [v2: Remove extra assembler operations, per hpa review]
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Reviewed-by: H. Peter Anvin <hpa@zytor.com>
> 
> Len, your tree or mine?

Well, I think you can take both, if that's not a problem. :-)

Rafael
