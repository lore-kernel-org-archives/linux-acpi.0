From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: DSDT in initrd?
Date: Fri, 9 May 2003 08:46:50 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305090833480.15104@dynast.gaugusch.at>
References: <Pine.LNX.4.53.0304282017540.1928@phoenix.kerstin.at>
 <20030504215051.GA488@elf.ucw.cz> <Pine.LNX.4.53.0305050829420.25721@dynast.gaugusch.at>
 <200305060007.49847.bob@diamond.demon.co.uk> <Pine.LNX.4.53.0305060743450.2529@tweety.gaugusch.at>
 <20030508210923.GA4466@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030508210923.GA4466-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On May 8, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> I don't think that 'magic' signature is good idea. It seems fragile...
The initrd filesystem is usually compressed, isn't it? ("file initrd"
returns "gzipped compressed data" for me).

So most clear-text strings will be messed up, especially if they have the
length and structure of mine (several parts are twice in the string).

Also, SuSE (I think you had an @suse email some time ago?) uses the same
technique for the bootsplash, and I think that something used by a major
distributor has probably been reviewed by a few peopl.

The only additional things I could check, are the bytes following the
signature and check if their value is "DSDT" (which is a good idea and
should be done).

I don't know if any other sanity checks can be done, but the ACPI
code could should already do that part for me anyway?

Markus

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
