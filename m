From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3 resume broken in 2.6.
Date: Tue, 22 Jun 2004 12:19:19 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406221219.20439.stefandoesinger@gmx.at>
References: <GMail.1087700004.208457790.35614235518@brewt.org> <200406211539.48269.stefandoesinger@gmx.at> <20040621141227.GD14607@wotan.suse.de>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040621141227.GD14607-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Which driver does your sound card drive? Better would be to give
> this driver an empty suspend/resume method that does nothing.
i810_audio or snd_intel8x0.
In my system, there's at least one other card which causes the same problem.
> > I attached a path which undoes the change described above and should make
> > S3 work again.
>
> Overall the pci config space save/restore fixes much more resume
> problems than it causes new one, so this sledgehammer is the wrong
> solution.
I agree. I'd prefer a solution for the pci_write config fix.
The strange thing is that I can fix the PCI configuration with setpci after 
resume.

Disabling the default resume is a quick help for my system.

I can provide further information if necessary.

Stefan


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
