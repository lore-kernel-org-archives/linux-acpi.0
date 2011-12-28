From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: Re: ACPI failures on Dell Latitude E6220
Date: Wed, 28 Dec 2011 17:29:43 +0100
Message-ID: <87d3b8oe14.fsf@pirx.pps.jussieu.fr>
References: <87r50zzvf6.fsf@pirx.pps.jussieu.fr>
	<87vcp998us.fsf@pirx.pps.jussieu.fr>
	<20111222100849.GA6548@elie.Belkin>
	<7iipl8d9kk.fsf@lanthane.pps.jussieu.fr>
	<8739cavt48.fsf@pirx.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:54874 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab1L1Q3x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Dec 2011 11:29:53 -0500
In-Reply-To: <8739cavt48.fsf@pirx.pps.jussieu.fr> (Juliusz Chroboczek's
	message of "Sat, 24 Dec 2011 17:20:39 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-acpi@vger.kernel.org

> I've tried 3.0.0-3, 3.1.1-1, 3.1.4-1, 3.1.5-1 and 3.2~rc4-1~experimental.1,
> and the system enters PC7 and has decent battery life under all of them.

Mystery solved -- PC7 is due to my adding "i915.i915_enable_rc6=1" to
the kernel's command-line.

Note that there are still ACPI failures under the older kernels, and
they do decrease battery usage -- but the effect is not as dramatic as
that of RC6.

-- Juliusz

