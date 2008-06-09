From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 09/11] bay: exit if notify handler cannot be installed
Date: Mon, 9 Jun 2008 16:56:28 -0700
Message-ID: <20080609165628.90e2cf7b.akpm@linux-foundation.org>
References: <200806092322.m59NMP01013979@imap1.linux-foundation.org>
	<20080609232817.GA21101@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32807 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969AbYFIX5U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:57:20 -0400
In-Reply-To: <20080609232817.GA21101@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, hmacht@suse.de, kristen.c.accardi@intel.com, rui.zhang@intel.com, trenn@suse.de

On Tue, 10 Jun 2008 00:28:17 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> It looks like the plan is to subsume the bay driver into the dock 
> driver. I'm not sure if this is needed in the short term until then?

Dunno.

This patch appears to fix a bug, in which case we shouldn't allow
larger future plans to get int he way of that?
