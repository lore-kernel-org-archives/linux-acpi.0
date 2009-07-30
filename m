From: Frans Pop <elendil@planet.nl>
Subject: Re: [Bug 13865] Can only resume with HP_WMI selected on compaq nc6000 when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is reverted
Date: Thu, 30 Jul 2009 11:56:01 +0200
Message-ID: <200907301156.03248.elendil@planet.nl>
References: <bug-13865-10028@http.bugzilla.kernel.org/> <200907292331.34214.elendil@planet.nl> <4A7165D8.8060705@belbone.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752402AbZG3J4H@vger.kernel.org>
In-Reply-To: <4A7165D8.8060705@belbone.be>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?q?C=C3=A9dric_Godin?= <cedric@belbone.be>, linux-kernel@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 30 July 2009, C=C3=A9dric Godin wrote:
> > The strange thing is that the resume function does not do anything
> > that's not also done in hp_wmi_input_setup(). The only thing I can
> > think of is that we might need to test for
> > wmi_has_guid(HPWMI_EVENT_GUID) because that model simply does not
> > support input events.
>
> I tested your patch (from buzilla) and now I can resume.

Great.

> Thanks ! You have my tested-by ;-)
>
> PS: I suppose you don't need this infos anymore ?

I'd still like to see the following if it's not too much trouble,=20
basically to confirm that the theory was indeed correct.

$ grep . /sys/devices/platform/hp-wmi/*
$ cat /proc/bus/input/devices

Thanks,
=46JP
