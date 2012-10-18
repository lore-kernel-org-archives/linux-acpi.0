From: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [Xen-devel] Is: axe read_tscp pvops call. Was: Re: [RFC] ACPI S3
 and Xen (suprisingly small\!).
Date: Thu, 18 Oct 2012 13:42:03 -0400
Message-ID: <20121018174200.GA20508@localhost.localdomain>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com>
 <507ED6C0.4020503@zytor.com>
 <20121017161036.GA10691@phenom.dumpdata.com>
 <507EE1C3.7070300@zytor.com>
 <20121017165452.GA22740@phenom.dumpdata.com>
 <50802EEC.6060102@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49566 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab2JRRmR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Oct 2012 13:42:17 -0400
Content-Disposition: inline
In-Reply-To: <50802EEC.6060102@citrix.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xensource.com, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, lenb@kernel.org

> As for 'perf', since Xen already provides a virtual PMU for HVM guests
> It's not clear why we would spend the effort to implement another
> mechanism for PV guests (instead of using the virtual PMU from a PVH guest).

Would that allow one to evaluate the performance/bottlenecks that the
hypervisor might have?
