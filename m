From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Repost: asus strict model checking
Date: Thu, 03 Aug 2006 10:40:13 +0200
Message-ID: <1154594413.4302.452.camel@queen.suse.de>
References: <1154438122.4302.354.camel@queen.suse.de>
	 <44CF5DF6.9090603@linux.intel.com>
	 <1154446149.4302.386.camel@queen.suse.de>
	 <44CF7D26.5050208@linux.intel.com>
	 <1154452931.4302.407.camel@queen.suse.de>
	 <44CF92EB.4010801@linux.intel.com>
	 <1154512820.4302.444.camel@queen.suse.de>
	 <44D0F3A7.4020405@linux.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:18155 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932398AbWHCIgn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 04:36:43 -0400
In-Reply-To: <44D0F3A7.4020405@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, acpi4asus-user@lists.sourceforge.net

On Wed, 2006-08-02 at 22:49 +0400, Alexey Starikovskiy wrote:
> I was referring to this peace of artwork(asus_info is pointer to DSDT header):
> ------------------------------------------------------------------------------
>         if (hotk->model == END_MODEL) { /* match failed */
>                 if (asus_info &&
>                     strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
>                         hotk->model = P30;
Oh yes, you are right this is awful.

   Thomas

