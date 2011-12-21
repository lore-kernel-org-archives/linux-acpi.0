From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: HP Envy 17 3D BIOS reports "Thermal Shutdown" on every reboot
 despite no thermal problems
Date: Wed, 21 Dec 2011 18:28:18 +0000
Message-ID: <20111221182817.GA25036@srcf.ucam.org>
References: <CAGZ=bqKqO328BQa7+0S-GNfmvgKurcB1Z66qbCMT7Fu3G=7Leg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51304 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab1LUS2V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2011 13:28:21 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ=bqKqO328BQa7+0S-GNfmvgKurcB1Z66qbCMT7Fu3G=7Leg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle Moffett <kyle@moffetthome.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Try the patch I sent entitled "[PATCH] ACPI: Evaluate thermal trip 
points before reading temperature".

-- 
Matthew Garrett | mjg59@srcf.ucam.org
