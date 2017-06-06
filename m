From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose
 embedded WMI MOF metadata
Date: Mon, 5 Jun 2017 19:33:25 -0700
Message-ID: <20170606023325.GB27270@fury>
References: <cover.1495862272.git.dvhart@infradead.org>
 <201705271314.16241@pali>
 <20170605221456.GA27270@fury>
 <201706060019.26462@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35585 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbdFFCd2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2017 22:33:28 -0400
Content-Disposition: inline
In-Reply-To: <201706060019.26462@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Jun 06, 2017 at 12:19:26AM +0200, Pali Rohár wrote:
> On Tuesday 06 June 2017 00:14:56 Darren Hart wrote:
> > On Sat, May 27, 2017 at 01:14:15PM +0200, Pali Rohár wrote:
> > > > metadata. I think that Samba has tools to interpret it, but there
> > > > is currently no interface to get the data in the first place.
> > > 
> > > No, there is no non-ms-windows tool for interpreting those binary
> > > MOF (BMF) data yet.
> > 
> > Good point. Updated.
> 
> You are too late :-) Now there is my at https://github.com/pali/bmfdec 
> See my email "Binary MOF buffer in WMI is finally decoded!".

I've seen it, nice work. Will spend more time on it once I get the v2 for this
out the door.

-- 
Darren Hart
VMware Open Source Technology Center
