From: Zbigniew Baniewski <zb@ispid.com.pl>
Subject: Re: ACPI-related bug caused poor responsitivity (2.6.26.x line)
Date: Fri, 15 Aug 2008 13:03:47 +0200
Message-ID: <20080815110347.GA5089@sarge.my.own.domain.no-net>
References: <20080814211348.GA6268@sarge.my.own.domain.no-net> <8763q3yq78.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v005705.home.net.pl ([212.85.118.117]:49728 "HELO
	v005705.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752877AbYHOLDv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 07:03:51 -0400
Content-Disposition: inline
In-Reply-To: <8763q3yq78.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Fri, Aug 15, 2008 at 04:20:11AM +0200, Andi Kleen wrote:

> I assume you double checked that? As in you removed the option again
> and the problem reappeared? And you add it again and it disappeared
> again? If not do so please.

Checked it several times.

> If it's checked please put a full report into http://bugzilla.kernel.org

OK, I'll do that.

> Might be some kind of power saving issue. Does it happen when 
> you boot with processor.max_cstate=1? (without acpi=off)

It hasn't been accepted as the boot parameter - but I've inserted it into
/etc/modprobe.d/processor and updated modules. And it made the situation
a bit better - I mean: no "jitter" during mouse movement anymore, but
still "momentary freeze" of GKrellm output (which isn't the case when
using 2.6.25.2 kernel).

> Does it happen when you disable CPUIDLE in the config?

You mean: CONFIG_CPU_IDLE=n ?
-- 
				pozdrawiam / regards

						Zbigniew Baniewski
