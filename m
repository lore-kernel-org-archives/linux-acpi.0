From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI source release updated (20030328)
Date: Sat, 29 Mar 2003 11:17:15 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030329181722.D7F0BF7E5F@voldemort.scrye.com>
References: <F760B14C9561B941B89469F59BA3A847E96D8E@orsmsx401.jf.intel.com>
	<20030329151604.GA19676@hell.org.pl>
	<200303291811.48633.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "P" == P Christeas <p_christ-U04EIuiosng@public.gmane.org> writes:

>> Thus wrote Grover, Andrew: > Fixed a problem where the error
>> message "Failed to acquire semaphore" > would appear during
>> operations on the embedded controller (EC).
>> 
>> Thanks for that!  I have one question though. Did you consider
>> doing incremental ACPI patches? I'm using a heavily patched kernel
>> with XFS filesystem support, and getting all these patches to work
>> and applying all the rejects manually is a real pain. Incremental
>> patches would really make life (mine, at least) easier. What do you
>> think about it?
>> 
>> (the above refers to the 2.4 kernel, with 2.5 changing so fast it
>> isn't really a problem)
>> 
>> Best regards,

P> I had thought of asking that as well. But it may be a pain for
P> Andrew to make those.  If you have all the source-patches you've
P> used, you might be able to do that yourself. Just get the
P> 'original' 2.4, patch it with 2 different ver's of ACPI and diff
P> those.. Then you could apply that diff as a patch to your
P> 'overloaded' ver of 2.4.

Yeah, there is also a package out there called 'interdiff'. Lets you
make a diff between two diff files. ;) 

interdiff acpi-20030321-2.4.21-pre5.diff acpi-20030328-2.4.21-pre6.diff > acpi.diff

It seems to get one reject on the acpi patches for some reason, but
that one looks cosmetic. 

Will try it on my heavily patched 2.4.21-pre5. ;) 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+heMx3imCezTjY0ERAp8+AJ0b/uqTf4Y0A3ZOUaE5/ZyuGDAn+wCdHExQ
PWF/JMHYT1yrPlo6UUMWv9c=
=bwxy
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
