From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: trace, RAS: New eMCA trace event interface
Date: Fri, 07 Mar 2014 06:10:47 -0300
Message-ID: <20140307061047.5c901413@samsung.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <5316136f1918986e5@agluck-desk.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:58967 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbaCGJKy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Mar 2014 04:10:54 -0500
Received: from uscpsbgm1.samsung.com
 (u114.gpu85.samsung.co.kr [203.254.195.114]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N2200FSC6U5ID00@mailout2.w2.samsung.com> for
 linux-acpi@vger.kernel.org; Fri, 07 Mar 2014 04:10:53 -0500 (EST)
In-reply-to: <5316136f1918986e5@agluck-desk.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, bp@alien8.de, arozansk@redhat.com, linux-acpi@vger.kernel.org

Hi Tony,

Em Tue, 04 Mar 2014 09:54:55 -0800
"Luck, Tony" <tony.luck@intel.com> escreveu:

> Here is (most of) the matching patch to rasdaemon to collect
> messages from this trace.  Rasdaemon lives at:
> 	git://git.fedorahosted.org/rasdaemon.git
> 
> Missing part is saving to sqlite data base - boiler plate is present,
> but the specifics to create tables and save to them need to be added.
> But this should serve as a useful test bed while we argue the punctuation
> in the fields supplied by the kernel trace.
> 
> Note: There are few platforms that fully support this at the moment. One
> is the "Brickland Ivy Bridge -EX" (Running BIOS 0046.R04 or newer). Another
> is the "Grantley Haswell -EP" (Running BIOS 0026 ... which I don't think is
> out yet).  Be sure to enable eMCA options in BIOS setup EDKII>Advanced>System Event Log.

Patch looks correct. I'll apply it after the corresponding Kernel patch
is applied.

As I just pointed, we'll also need some code at the rasdaemon that would
associate the CPER error location data into the corresponding DIMM label.

Regards,
Mauro
> 
> -Tony
> 
> ---
> 
> 
> From: "Luck, Tony" <tony.luck@intel.com>
> 
> [RASDAEMON] Add support for extlog events reported by the kernel
> 
> Kernel may report extra platform specific information provided by
> BIOS. Capture it and log it.
> 
> TODO: log to the SQLITE data base - just top level hooks present
> in this patch.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> 
> diff --git a/Makefile.am b/Makefile.am
> index c1668b4d939d..2f81d777823c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -17,13 +17,17 @@ if WITH_MCE
>  			mce-intel-dunnington.c mce-intel-tulsa.c \
>  			mce-intel-sb.c mce-intel-ivb.c
>  endif
> +if WITH_EXTLOG
> +   rasdaemon_SOURCES += ras-extlog-handler.c
> +endif
>  if WITH_ABRT_REPORT
>     rasdaemon_SOURCES += ras-report.c
>  endif
>  rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
>  
>  include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
> -		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h
> +		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
> +		  ras-extlog-handler.h
>  
>  # This rule can't be called with more than one Makefile job (like make -j8)
>  # I can't figure out a way to fix that
> diff --git a/configure.ac b/configure.ac
> index 5bd824c0dbe2..b050ad864cdf 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -53,6 +53,15 @@ AS_IF([test "x$enable_mce" = "xyes"], [
>  ])
>  AM_CONDITIONAL([WITH_MCE], [test x$enable_mce = xyes])
>  
> +AC_ARG_ENABLE([extlog],
> +    AS_HELP_STRING([--enable-extlog], [enable EXTLOG events (currently experimental)]))
> +
> +AS_IF([test "x$enable_extlog" = "xyes"], [
> +  AC_DEFINE(HAVE_EXTLOG,1,"have EXTLOG events collect")
> +  AC_SUBST([WITH_EXTLOG])
> +])
> +AM_CONDITIONAL([WITH_EXTLOG], [test x$enable_extlog = xyes])
> +
>  AC_ARG_ENABLE([abrt_report],
>      AS_HELP_STRING([--enable-abrt-report], [enable report event to ABRT (currently experimental)]))
>  
> diff --git a/ras-events.c b/ras-events.c
> index ecbbd3afa66d..90ea3727f667 100644
> --- a/ras-events.c
> +++ b/ras-events.c
> @@ -30,6 +30,7 @@
>  #include "ras-mc-handler.h"
>  #include "ras-aer-handler.h"
>  #include "ras-mce-handler.h"
> +#include "ras-extlog-handler.h"
>  #include "ras-record.h"
>  #include "ras-logger.h"
>  
> @@ -203,6 +204,10 @@ int toggle_ras_mc_event(int enable)
>  	rc |= __toggle_ras_mc_event(ras, "mce", "mce_record", enable);
>  #endif
>  
> +#ifdef HAVE_EXTLOG
> +	rc |= __toggle_ras_mc_event(ras, "ras", "extlog_mem_event", enable);
> +#endif
> +
>  free_ras:
>  	free(ras);
>  	return rc;
> @@ -688,6 +693,17 @@ int handle_ras_events(int record_events)
>  		    "mce", "mce_record");
>  	}
>  #endif
> +
> +#ifdef HAVE_EXTLOG
> +	rc = add_event_handler(ras, pevent, page_size, "ras", "extlog_mem_event",
> +			       ras_extlog_mem_event_handler);
> +	if (!rc)
> +		num_events++;
> +	else
> +		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
> +		    "ras", "aer_event");
> +#endif
> +
>  	if (!num_events) {
>  		log(ALL, LOG_INFO,
>  		    "Failed to trace all supported RAS events. Aborting.\n");
> diff --git a/ras-extlog-handler.c b/ras-extlog-handler.c
> new file mode 100644
> index 000000000000..1166a5341703
> --- /dev/null
> +++ b/ras-extlog-handler.c
> @@ -0,0 +1,134 @@
> +/*
> + * Copyright (C) 2014 Tony Luck <tony.luck@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +*/
> +#include <ctype.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include "libtrace/kbuffer.h"
> +#include "ras-extlog-handler.h"
> +#include "ras-record.h"
> +#include "ras-logger.h"
> +#include "ras-report.h"
> +
> +static char *err_type(int etype)
> +{
> +	switch (etype) {
> +	case 0: return "unknown";
> +	case 1: return "no error";
> +	case 2: return "single-bit ECC";
> +	case 3: return "multi-bit ECC";
> +	case 4: return "single-symbol chipkill ECC";
> +	case 5: return "multi-symbol chipkill ECC";
> +	case 6: return "master abort";
> +	case 7: return "target abort";
> +	case 8: return "parity error";
> +	case 9: return "watchdog timeout";
> +	case 10: return "invalid address";
> +	case 11: return "mirror Broken";
> +	case 12: return "memory sparing";
> +	case 13: return "scrub corrected error";
> +	case 14: return "scrub uncorrected error";
> +	case 15: return "physical memory map-out event";
> +	}
> +	return "unknown-type";
> +}
> +
> +static char *err_severity(int severity)
> +{
> +	switch (severity) {
> +	case 0: return "recoverable";
> +	case 1: return "fatal";
> +	case 2: return "corrected";
> +	case 3: return "informational";
> +	}
> +	return "unknown-severity";
> +}
> +
> +static void report_extlog_mem_event(struct ras_events *ras,
> +				    struct pevent_record *record,
> +				    struct trace_seq *s,
> +				    struct ras_extlog_event *ev)
> +{
> +	trace_seq_printf(s, "%d %s error: %s %s physical addr: 0x%llx (%s %s)",
> +		ev->error_count, err_severity(ev->severity),
> +		err_type(ev->etype), ev->dimm_info, ev->address,
> +		ev->mem_loc, ev->fru);
> +}
> +
> +int ras_extlog_mem_event_handler(struct trace_seq *s,
> +			  struct pevent_record *record,
> +			  struct event_format *event, void *context)
> +{
> +	int len;
> +	unsigned long long val;
> +	struct ras_events *ras = context;
> +	time_t now;
> +	struct tm *tm;
> +	struct ras_extlog_event ev;
> +
> +	/*
> +	 * Newer kernels (3.10-rc1 or upper) provide an uptime clock.
> +	 * On previous kernels, the way to properly generate an event would
> +	 * be to inject a fake one, measure its timestamp and diff it against
> +	 * gettimeofday. We won't do it here. Instead, let's use uptime,
> +	 * falling-back to the event report's time, if "uptime" clock is
> +	 * not available (legacy kernels).
> +	 */
> +
> +	if (ras->use_uptime)
> +		now = record->ts/1000000000L + ras->uptime_diff;
> +	else
> +		now = time(NULL);
> +
> +	tm = localtime(&now);
> +	if (tm)
> +		strftime(ev.timestamp, sizeof(ev.timestamp),
> +			 "%Y-%m-%d %H:%M:%S %z", tm);
> +	trace_seq_printf(s, "%s ", ev.timestamp);
> +
> +	if (pevent_get_field_val(s,  event, "etype", record, &val, 1) < 0)
> +		return -1;
> +	ev.etype = val;
> +	if (pevent_get_field_val(s,  event, "error_count", record, &val, 1) < 0)
> +		return -1;
> +	ev.error_count = val;
> +	if (pevent_get_field_val(s,  event, "severity", record, &val, 1) < 0)
> +		return -1;
> +	ev.severity = val;
> +	if (pevent_get_field_val(s,  event, "paddr", record, &val, 1) < 0)
> +		return -1;
> +	ev.address = val;
> +
> +	ev.dimm_info = pevent_get_field_raw(s, event, "dimm_info",
> +					   record, &len, 1);
> +	ev.mem_loc = pevent_get_field_raw(s, event, "mem_loc",
> +					   record, &len, 1);
> +	ev.fru = pevent_get_field_raw(s, event, "fru",
> +					   record, &len, 1);
> +
> +	report_extlog_mem_event(ras, record, s, &ev);
> +
> +#ifdef HAVE_SQLITE3
> +	ras_store_extlog_mem_record(ras, &ev);
> +#endif
> +
> +	return 0;
> +}
> diff --git a/ras-extlog-handler.h b/ras-extlog-handler.h
> new file mode 100644
> index 000000000000..54e8cec93af9
> --- /dev/null
> +++ b/ras-extlog-handler.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (C) 2014 Tony Luck <tony.luck@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +*/
> +
> +#ifndef __RAS_EXTLOG_HANDLER_H
> +#define __RAS_EXTLOG_HANDLER_H
> +
> +#include <stdint.h>
> +
> +#include "ras-events.h"
> +#include "libtrace/event-parse.h"
> +
> +extern int ras_extlog_mem_event_handler(struct trace_seq *s,
> +			  struct pevent_record *record,
> +			  struct event_format *event, void *context);
> +
> +#endif
> diff --git a/ras-record.c b/ras-record.c
> index daa3cb102883..6b4cf548bb46 100644
> --- a/ras-record.c
> +++ b/ras-record.c
> @@ -157,6 +157,28 @@ int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev)
>  }
>  #endif
>  
> +#ifdef HAVE_EXTLOG
> +static const struct db_fields extlog_event_fields[] = {
> +		{ .name="id",			.type="INTEGER PRIMARY KEY" },
> +		{ .name="timestamp",		.type="TEXT" },
> +};
> +
> +static const struct db_table_descriptor extlog_event_tab = {
> +	.name = "extlog_event",
> +	.fields = extlog_event_fields,
> +	.num_fields = ARRAY_SIZE(extlog_event_fields),
> +};
> +
> +int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event *ev)
> +{
> +
> +	/*
> +	 * TODO: Define the right fields above (extlog_event_fields[]) and
> +	 * add code here to save them to the database
> +	 */
> +	return 0;
> +}
> +#endif
>  
>  /*
>   * Table and functions to handle mce:mce_record
> @@ -384,6 +406,13 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
>  					 &aer_event_tab);
>  #endif
>  
> +#ifdef HAVE_EXTLOG
> +	rc = ras_mc_create_table(priv, &extlog_event_tab);
> +	if (rc == SQLITE_OK)
> +		rc = ras_mc_prepare_stmt(priv, &priv->stmt_extlog_record,
> +					 &extlog_event_tab);
> +#endif
> +
>  #ifdef HAVE_MCE
>  	rc = ras_mc_create_table(priv, &mce_record_tab);
>  	if (rc == SQLITE_OK)
> diff --git a/ras-record.h b/ras-record.h
> index 6f146a875b8e..715bfbbedacc 100644
> --- a/ras-record.h
> +++ b/ras-record.h
> @@ -40,8 +40,20 @@ struct ras_aer_event {
>  	const char *msg;
>  };
>  
> +struct ras_extlog_event {
> +	char timestamp[64];
> +	int etype;
> +	int error_count;
> +	int severity;
> +	unsigned long long address;
> +	const char *dimm_info;
> +	const char *mem_loc;
> +	const char *fru;
> +};
> +
>  struct ras_mc_event;
>  struct ras_aer_event;
> +struct ras_extlog_event;
>  struct mce_event;
>  
>  #ifdef HAVE_SQLITE3
> @@ -57,18 +69,23 @@ struct sqlite3_priv {
>  #ifdef HAVE_MCE
>  	sqlite3_stmt	*stmt_mce_record;
>  #endif
> +#ifdef HAVE_EXTLOG
> +	sqlite3_stmt	*stmt_extlog_record;
> +#endif
>  };
>  
>  int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras);
>  int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev);
>  int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev);
>  int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev);
> +int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event *ev);
>  
>  #else
>  static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
>  static inline int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev) { return 0; };
>  static inline int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev) { return 0; };
>  static inline int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev) { return 0; };
> +static inline int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event *ev) { return 0; };
>  
>  #endif
>  


-- 

Cheers,
Mauro
