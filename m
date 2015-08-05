From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] Exporting extra tables for machines without /dev/mem
Date: Thu, 06 Aug 2015 01:38:17 +0200
Message-ID: <3652879.LaH6kkGZ8g@vostro.rjw.lan>
References: <1437485468-17107-1-git-send-email-graeme.gregory@linaro.org> <55C27122.8040604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51344 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751305AbbHEXLM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 19:11:12 -0400
In-Reply-To: <55C27122.8040604@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, August 05, 2015 02:25:06 PM Al Stone wrote:
> On 07/21/2015 07:31 AM, Graeme Gregory wrote:
> > Hi,
> > 
> > I thought I would send this patch as an RFC. It is something I did when
> > another linaro engineer was modifying acpica-tools to not require /dev/mem.
> > 
> > It exports the 3 tables that are not currenly exported in sysfs.
> > 
> > Currently I do not think there is any user of this because acpica-tools can
> > can recover the information in the other tables without these three being
> > exported, fwts also works fine without the patch so the only use case I have
> > is the vague "might be useful for debug"
> 
> Right -- and I personally would like to have that debug use case.  AFAICT,
> the RSDP and RSDT/XSDT are recreated by acpidump; i.e., based on knowledge
> of the mapped tables, acpidump builds what it believes these tables should
> look like.  But, the /dev/mem mappings would give me what ACPI is actually
> using (what was directly passed to the kernel).  Should there be a bug in
> table mapping or ACPI startup, this info might help.

If my memory serves me right, Lv has been doing something in that area.  Lv?

