From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: [Acpi4asus-user] ASUS M2400N / M3700N / S1300N temperature
Date: Mon, 25 Aug 2003 09:13:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030825071302.GI19292@poupinou.org>
References: <20030814025858.GA16098@hell.org.pl> <1060944604.1760.1.camel@M2400N> <20030815142258.GA2643@hell.org.pl> <1060959167.2144.19.camel@Home> <20030815205541.GB25102@hell.org.pl> <1061221384.1996.6.camel@M2400N> <20030819140334.GB4265@hell.org.pl> <20030819141349.GM18032@poupinou.org> <1061630529.1927.1.camel@M2400N>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1061630529.1927.1.camel-m6aJA0iQrH4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 23, 2003 at 11:22:09AM +0200, Mads Paulin wrote:
> On Tue, 2003-08-19 at 16:13, Ducrot Bruno wrote:
> 
> --snip
> 
> > > This is the original one. If the (RBYT (TSAD, 0x01) is supposed to return
> > > temperature, it should rather not be zero. Thus, the condition in RTMP
> > > always fails. Since LTMP is initialized with 0x3c (60d), the _TMP method
> > > always returns (KELV (60)), and also, since RTMP is also used internally,
> > > the fan keeps spinning at the same speed. 
> > 
> > Problem is: I still don't have time to debug that.  A good approach
> > imho for debugging all that stuff is to simulate the RTMP by
> > translating this method in C.  It's straightforward, but sorry, I don't
> > have time for.  Then you will see if it is a bug in the aml interpreter,
> > or a bug in the AML.
> 
> -- snip
> 
> Hi,
> 
> How is the AML converted to C? By just writing a small program that
> reads the same memory adresses ??
> 

Something like that, yes.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
