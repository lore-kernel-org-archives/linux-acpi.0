From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: any way to evaluate a device's _PS0 method when its power
 state is at D0?
Date: Thu, 19 May 2011 13:42:21 +0100
Message-ID: <20110519124221.GA11831@srcf.ucam.org>
References: <BANLkTim-sswOsPZZzH7QOWQgqpwJ_EzeNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56581 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584Ab1ESMm0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2011 08:42:26 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim-sswOsPZZzH7QOWQgqpwJ_EzeNQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: aaron lwe <aaron.lwe@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, May 19, 2011 at 06:06:47PM +0800, aaron lwe wrote:

> So on init, this device's power state will be set to D0 due to ABPS is
> 0, but its _PS0 never get called.
> If later I want to evaluate its _PS0 control method, what should I do?
> acpi_bus_set_power will return if it found the set state is the same
> with the current state.

Why do you want to evaluate its _PS0 method?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
