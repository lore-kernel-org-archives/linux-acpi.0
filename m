From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: kacpid and acpid
Date: Wed, 30 Apr 2008 17:08:52 +0100
Message-ID: <20080430160852.GA3554@srcf.ucam.org>
References: <fv9tlv$2v0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:51805 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbYD3RBG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 13:01:06 -0400
Content-Disposition: inline
In-Reply-To: <fv9tlv$2v0$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Feldmann <feldmann_markus@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Wed, Apr 30, 2008 at 03:54:05PM +0200, Markus Feldmann wrote:

> my Problem is that i can not install "acpid" and "acpi-support" 
> correctly, because another Process "kacpid" have got Access to
> /proc/acpi/event

No, it doesn't. Something else must have grabbed /proc/acpi/event 
(probably hal or X), but kacpid is not the process in question.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
