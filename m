From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 05/10] acpi: use __init* on everything in
 tables/tbfadt.c
Date: Thu, 1 May 2008 12:37:30 -0700
Message-ID: <20080501123730.7b61227c.akpm@linux-foundation.org>
References: <200805010952.m419q40A031809@imap1.linux-foundation.org>
	<1209668151.1131.60.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41597 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765669AbYEAThv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 May 2008 15:37:51 -0400
In-Reply-To: <1209668151.1131.60.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: jbeulich@novell.com, lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com

On Thu, 01 May 2008 20:55:51 +0200
Thomas Renninger <trenn@suse.de> wrote:

> Andrew, IMO you can drop this and the const cleanups from -mm tree.

I cannot locate a patch which matches the description "const cleanups"?
