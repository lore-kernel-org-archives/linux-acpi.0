From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: how to get acpi info inside the kernel?
Date: Mon, 2 Mar 2009 02:23:09 +0000
Message-ID: <20090302022309.GA20075@srcf.ucam.org>
References: <4a33b1190903011741l3698db9cg70bf9bf2108fc868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59467 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbZCBCXN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Mar 2009 21:23:13 -0500
Content-Disposition: inline
In-Reply-To: <4a33b1190903011741l3698db9cg70bf9bf2108fc868@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lourival Neto <lourival.neto@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, Mar 01, 2009 at 10:41:48PM -0300, Lourival Neto wrote:

> I'm writing a cpufreq governor and I want to use some acpi info, like
> temperature, to make decisions. Is there a way to get this info inside
> the kernel without use sysfs? Where can I find linux-acpi interface
> documentation?

There isn't one, as such. You can either evaluate the ACPI methods 
yourself or in the case of thermal-related values you can use the 
generic thermal code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
