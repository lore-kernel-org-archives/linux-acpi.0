From: Ingo Molnar <mingo@elte.hu>
Subject: Re: state of some x86 acpi patches
Date: Tue, 16 Dec 2008 20:25:34 +0100
Message-ID: <20081216192534.GB843@elte.hu>
References: <4947FF4C.80706@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:49421 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbYLPTZr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 14:25:47 -0500
Content-Disposition: inline
In-Reply-To: <4947FF4C.80706@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Brown, Len" <len.brown@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Hi Len,
>
> Have you seen these three patches?  Do they look OK to you?
>
> Yinghai Lu improve the third patch ("acpi: remove final __acpi_map_table 
> mapping before setting acpi_gbl_permanent_mmap"), which I think Ingo 
> sent you instead.

Len,

i asked about these patches before too - and if that's fine with you we'd 
just queue them up in the x86 tree (like we did before the .28 merge 
window). Most of the impact will be on x86. So an Acked-by from you would 
be fine to start this.

	Ingo
