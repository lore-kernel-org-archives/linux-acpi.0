From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: Re: INFO: possible circular locking dependency - kacpid
	acpi_os_wait_events_complete
Date: Tue, 25 Aug 2009 22:33:30 +0200
Message-ID: <c4e36d110908251333p2da20276j650232cea8da4c1f@mail.gmail.com>
References: <c4e36d110908250110xe16720o977c8cf5c3386c4b@mail.gmail.com>
	 <200908251251.37135.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756099AbZHYUdd@vger.kernel.org>
In-Reply-To: <200908251251.37135.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

2009/8/25 Bjorn Helgaas <bjorn.helgaas@hp.com>:
> On Tuesday 25 August 2009 02:10:58 am Zdenek Kabelac wrote:
>> Now with 2.6.31-rc7 (3edf2fb9d80a46d6c32ba12547a42419845b4b76)
>> =A0I'm getting this =A0INFO trace - also I've noticed complete reset=
 during resume
>> which could be eventually related to this ?
>
> What's the most recent kernel where this did not occur? =A0Is this
> a regression since 2.6.30?
>
>> My machine - T61, 4GB, C2D
>> I suspect that some resent =A0thinkpad-acpi changes.
>
> Do you have any evidence that points to thinkpad_acpi? =A0I looked
> at the recent changes there, and I don't see anything obviously
> related to kacpid or deferred work.
>

Well I've never seen this INFO trace before - also I'm not sure I
could reliable retest it - might be coincidence of suspend out of port
replicator and resume while being attached on it - however I do this
relatively often and I start to see this after I' started to use -rc7
kernel.

My guess is purely based on the fact that commit touching functions
from INFO trace was recently merged to main tree.

If there will be some time I could try to make few tests for suspend
resume - but I hope the trace would be enough for analysis.

Zdenek
