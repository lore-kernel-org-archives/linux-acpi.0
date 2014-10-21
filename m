From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] ACPI/EC: Cleanup debugging messages and coding styles.
Date: Tue, 21 Oct 2014 15:26:58 +0200
Message-ID: <2133206.nBnraRj3x0@vostro.rjw.lan>
References: <cover.1413267704.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58684 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932170AbaJUNGf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2014 09:06:35 -0400
In-Reply-To: <cover.1413267704.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Tuesday, October 14, 2014 02:23:33 PM Lv Zheng wrote:
> This patchset contains trivial cleanup code to make it easier to search in
> the EC debugging messages.
> It also includes a patch to correct coding style issues that detected by
> recent scripts/checkpatch.pl.
> 
> No functional changes. This patchset can only make remote debugging more
> efficient.
> 
> Lv Zheng (5):
>   ACPI/EC: Add CPU ID to debugging messages.
>   ACPI/EC: Enhance the logs to apply to QR_EC transactions.
>   ACPI/EC: Add detailed command/query debugging information.
>   ACPI/EC: Refine event/query debugging messages.
>   ACPI/EC: Cleanup coding style.
> 
>  drivers/acpi/ec.c |  109 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 70 insertions(+), 39 deletions(-)

Applied, except for one thing (please see the comment on patch [5/5]).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
