From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Date: Tue, 25 Feb 2003 21:09:07 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030225200907.GJ13404@poup.poupinou.org>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org> <3E5B835E.7050601@symplon.com> <20030225151341.GI13404@poup.poupinou.org> <20030225174449.GD12028@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030225174449.GD12028-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

On Tue, Feb 25, 2003 at 06:44:49PM +0100, Pavel Machek wrote:
> 
> I've received it after I made my patch, and I think that more machine
> with broken tables will be created in future...
> 

That it not the answer I expected.  To be more clear: you report errors
on _STA and _INI.  I don't know why.  But with my previous patch, it seems
that there is no such errors (but it is with 2.4).
And one of the suspect(s) for what I know is your mem= option patch.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
