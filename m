From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: _CST implementation
Date: Tue, 19 Apr 2005 11:22:51 +0200
Message-ID: <20050419092251.GK2298@poupinou.org>
References: <1113598244.8367.30.camel@scotchmobil> <20050418120744.GG2298@poupinou.org> <4263EDA2.4030106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4263EDA2.4030106-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 18, 2005 at 07:25:54PM +0200, Thomas Renninger wrote:
> Bruno Ducrot wrote:
> > On Fri, Apr 15, 2005 at 10:50:44PM +0200, Janosch Machowinski wrote:
> ...
> > 
> >>Oh I almost forgot another question : 
> >>About the validation of the C states. At the moment it is tested if the
> >>latency of C2 if under 100 and if C3 latency is under 1000 but the
> >>ACPI-Spec says that "There is no latency restrictions" so why do you do
> >>this ? (My notebook hat a C3 latency of 1001)
> > 
> > Normally you are right, but unfortunately there are still some strange
> > misread of the specification by bios writters in that regard.  Therefore
> > if for C3 the latency is 1001 even if given by _CST, we should disable
> > it.
> > 
> 
> My spec says (Revision 3.0, September 2, 2004):
> The worst-case hardware latency for this state is declared in the FADT
> (p. 257).
> 
> And there they say (p. 98):
> The worst-case hardware latency, in microseconds, to enter and
> exit a C2 state. A value > 100 indicates the system does not
> support a C2 state.
> The worst-case hardware latency, in microseconds, to enter and
> exit a C3 state. A value > 1000 indicates the system does not
> support a C3 state.
> 

For P_LVL2_LAT and P_LVL3_LAT defined in the FADT only.  There are no
such restriction if _CST exist (see 8.1.5 and 8.4.2).
If power states are defined via _CST, then all of them are valid.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
