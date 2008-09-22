From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
	GPEs) on Asus EeePC
Date: Mon, 22 Sep 2008 09:20:07 +0800
Message-ID: <1222046407.3999.119.camel@yakui_zhao.sh.intel.com>
References: <48D695B3.5000303@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6396 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbYIVBPB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Sep 2008 21:15:01 -0400
In-Reply-To: <48D695B3.5000303@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, 2008-09-21 at 19:42 +0100, Alan Jenkins wrote:
Hi, Alan
    As I said in http://bugzilla.kernel.org/show_bug.cgi?id=11089#C27,
the bug on the Asus-EEPC can be fixed by your patch. But maybe some
other systems will be broken by your patch.
    For example: 
    On my laptop when issuing the query command, a non-zero query event
is returned but it can't be processed.(There is no corresponding ACPI
_Qxx object). At the same time the SCI_EVT bit won't be cleared. In such
case OS can't exit the function of acpi_ec_query_handler,which causes
that the acpid kernel thread can't work well.
    
    At the same time there also exist the following two issues on the
Asus-EEEPC. 
    a. EC GPE storm. (The pulse waveform given by EC is too wide).
    b. EC notification event is triggered too quickly. Before the EC
notification event is queried, another EC notification event is
triggered again. In such case some EC notification event will be lost
unless EC driver continues to query the EC notification event until zero
is returned. (As suggested in the Alan's patch).

    IMO you had better report your issues to Asus. Maybe the issue can
be fixed by upgrading BIOS.
    Thanks.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

