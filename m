From: "Brown, Len" <len.brown@intel.com>
Subject: RE: C4 state missing on T60p (Intel Core Duo)
Date: Wed, 9 Aug 2006 18:28:27 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60133D600@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58116 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751407AbWHIW2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2006 18:28:32 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Smertnig <daniel.smertnig@gmail.com>, linux-acpi@vger.kernel.org

For this system...

On DC: OS C3 = HW C4
On AC: OS C3 = HW C3

This is a common BIOS implementation choice.
The reasoning is that on AC you are more interested in lower
latency than you are interested in increased power savings.

They could have equally decided to expose 4 C-states no matter
AC or DC, but a popular binary OS would just ignore C3 in that
case and use only C4.
 
On AC/DC events, _CST is re-evaluated and the BIOS
gives the OS a different answer.  We don't print out the
IO address used to enter the state, but if we did,
you'd find that it changes along with the reported latency.

> AC:
>    C3:                  type[C3] promotion[--] demotion[C2]
>latency[017] usage[02945663]
>active state:            C3
>max_cstate:              C8
>bus master activity:     00000000
>states:
>    C1:                  type[C1] promotion[C2] demotion[--]
>latency[000] usage[00000010]
>    C2:                  type[C2] promotion[C3] demotion[C1]
>latency[001] usage[04745508]
>   *C3:                  type[C3] promotion[--] demotion[C2]
>latency[017] usage[05832946]
>
>battery:
>daniel-mobile% cat /proc/acpi/processor/*/power
>active state:            C2
>max_cstate:              C8
>bus master activity:     ffffff40
>states:
>    C1:                  type[C1] promotion[C2] demotion[--]
>latency[000] usage[00000010]
>   *C2:                  type[C2] promotion[C3] demotion[C1]
>latency[001] usage[00000119]
>    C3:                  type[C3] promotion[--] demotion[C2]
>latency[057] usage[00000000]
>active state:            C2
>max_cstate:              C8
>bus master activity:     ffffffec

The reason you are not entering  OS C3 when on DC is because
of bus master activity.

To ignore it, do this:

# echo 0 > /sys/module/processor/parameters/bm_history

cheers,
-Len

>states:
>    C1:                  type[C1] promotion[C2] demotion[--]
>latency[000] usage[00000010]
>   *C2:                  type[C2] promotion[C3] demotion[C1]
>latency[001] usage[00000158]
>    C3:                  type[C3] promotion[--] demotion[C2]
>latency[057] usage[00000000]
