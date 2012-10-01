From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH 2/2] ACPI: EC: Add a quirk for CLEVO M720T/M730T laptop
Date: Mon, 1 Oct 2012 18:10:32 +0200
Message-ID: <20121001161032.29368.qmail@stuge.se>
References: <1348816921-2637-1-git-send-email-feng.tang@intel.com> <1348816921-2637-2-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foo.stuge.se ([212.116.89.98]:40444 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752788Ab2JAQKf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2012 12:10:35 -0400
Content-Disposition: inline
In-Reply-To: <1348816921-2637-2-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Francesco <trentini@dei.unipd.it>

Feng Tang wrote:
> +/*
> + * Clevo M720 notebook actually works ok with IRQ mode, if we lifted
> + * the GPE storm threshold back to 20
> + */
> +static int ec_enlarge_storm_threshold(const struct dmi_system_id *id)

This function name is very generic. Maybe there will be different
thresholds needed in the future. Is it a good idea to name the
function ec_set_storm_threshold_20 instead?


//Peter
