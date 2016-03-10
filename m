From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA / Interpreter: Fix a regression triggered because of wrong Linux ECDT support
Date: Thu, 10 Mar 2016 23:10:57 +0100
Message-ID: <1882542.eo7s0UttuH@vostro.rjw.lan>
References: <1457578469-1859-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41488 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932453AbcCJWJE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 17:09:04 -0500
In-Reply-To: <1457578469-1859-1-git-send-email-lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, March 10, 2016 10:54:29 AM Lv Zheng wrote:
> It is reported that the following commit triggers regressions:
>  Linux commit: efaed9be998b5ae0afb7458e057e5f4402b43fa0
>  ACPICA commit: 31178590dde82368fdb0f6b0e466b6c0add96c57
>  Subject: ACPICA: Events: Enhance acpi_ev_execute_reg_method() to
>           ensure no _REG evaluations can happen during OS early boot
>           stages
> 
> This is because that the ECDT support is not corrected in Linux, and Linux
> requires to execute _REG for ECDT (though this sounds so wrong), we need to
> ensure acpi_gbl_namespace_initialized is set before ECDT probing in order
> for _REG to be executed. Since we have to move
> "acpi_gbl_namespace_initialized = TRUE" to the initialization step
> happening before ECDT probing, acpi_load_tables() is the best candidate for
> now. Thus this patch fixes the regression by doing so.
> 
> But if the ECDT support is fixed, Linux will not execute _REG for ECDT, and
> ECDT probing will happen before acpi_load_tables(). At that time, we still
> want to ensure acpi_gbl_namespace_initialized is set after executing
> acpi_ns_initialize_objects() (under the condition of
> acpi_gbl_group_module_level_code = FALSE), this patch also moves
> acpi_ns_initialize_objects() to acpi_load_tables() accordingly.
> 
> Since acpi_ns_initialize_objects() doesn't seem to be skippable, this
> patch also removes ACPI_NO_OBJECT_INIT for the one invoked in
> acpi_load_tables(). And since the default region handlers should always be
> installed before loading the tables, this patch also removes useless
> acpi_gbl_group_module_level_code check accordingly. Reported by Chris
> Bainbridge, Fixed by Lv Zheng.
> 
> Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

This is a bit too late for v4.5, so I'm queuing it up for 4.6 on top of
the other ACPICA changes already in my tree.

It actually may go to 4.5-stable I think, but first I'd like it to spend
some time in the mainline in case there are side-effects.

Thanks,
Rafael

