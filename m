From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12468] New: Crash in acpi_cpufreq_init
Date: Sat, 17 Jan 2009 11:17:38 -0800
Message-ID: <20090117111738.067709b3.akpm@linux-foundation.org>
References: <bug-12468-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58276 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763379AbZAQTSS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Jan 2009 14:18:18 -0500
In-Reply-To: <bug-12468-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org


> On Sat, 17 Jan 2009 10:47:32 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=12468

post-2.6.28 regression. It does appear to be acpi-related.
