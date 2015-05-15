From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Fri, 15 May 2015 10:35:28 +0200
Message-ID: <20150515083528.GA15215@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <5555A64D.6060200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:40451 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbbEOIfd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 04:35:33 -0400
Content-Disposition: inline
In-Reply-To: <5555A64D.6060200@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org

On Fri, May 15, 2015 at 09:54:53AM +0200, Daniel Lezcano wrote:
> 
> Hi Gianluca,
> 
> do yo have the option "Remain off after power failure" in the BIOS ?
> 
> Does the issue occur if you set this option ?

Hi,

The BIOS option "Restore AC Power Loss" is set to "Power Off".

The other options are "Last State" and "Power On". I could change it to "Last
State", I can do it later if needed since I've no physical access to the PC
right now.

However I'm beginning to think it's the NIC driver, even though it occurs also
with no cable attached, I sent a while ago an email with my findings.

Thank you,

Gianluca
