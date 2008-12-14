From: =?iso-8859-1?Q?S=E9bastien?= Hinderer
	<Sebastien.Hinderer@ens-lyon.org>
Subject: Buggy DSDT on Dell Latitude E5400
Date: Sun, 14 Dec 2008 03:21:25 +0100
Message-ID: <20081214022125.GA29259@zen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:64340 "EHLO
	mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751794AbYLNCct (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Dec 2008 21:32:49 -0500
Received: from seb by zen.loria.fr with local (Exim 4.69)
	(envelope-from <Sebastien.Hinderer@ens-lyon.org>)
	id 1LBgbl-0007cJ-Ms
	for linux-acpi@vger.kernel.org; Sun, 14 Dec 2008 03:21:25 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear all,

On a recently bought Dell Latitude E5400 laptop with Debian unstable
installed, the fan is constantly working.
This happens although the temperature reported by acpi -v is around 30
degrees Celcius, and although top reports a CPU usage around 1%.

Moreover, when the installed Windows XP is started and the machine is
left untouched, the fan remains turned off all the time.

Are these symptoms the consequence of a buggy DSDT which Windows
overrides ? 
In that case, how can the problem be fixed ?
Is it necessary to disassemble and study the DSDT, or is it possible to
somehow fetch the working one presumably used by Windows XP ?

Any help / suggestion warmly appreciated.
Kind regards,
Sebastien.
