From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: ACPI on hp Tablet TC1100
Date: Fri, 25 Mar 2005 12:44:38 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0503251235310.1110@frog.athome>
References: <Pine.LNX.4.58.0503241657510.4376@dashnine>  <1111704587.11677.27.camel@tyrosine>
  <Pine.LNX.4.58.0503241901440.4867@dashnine> <1111723887.11677.33.camel@tyrosine>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <1111723887.11677.33.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Matthew & Joshua,
On Fri, 25 Mar 2005, Matthew Garrett wrote:
> On Thu, 2005-03-24 at 19:24 -0500, Joshua Wise wrote:
>> I guess I should try starting X and doing a susp/res from there as the
>> logical next step. Testing... Hangs up on resume, no wifi on resume... dunno
>> if that's an artifact of nvidia just being initialized (and hence hanging)
>> first, or what.
>
> Seriously, give up on the nvidia driver if you want working ACPI. It
> just doesn't work properly. If I had the source code I'd try to debug
> it, but, well...
I am sorry to not having followed the full thread, and I do not know the 
nvidia-chipset of your tablet. I use a Geforce2go (ok. this is ancient 
hardware... in an Acer TM63x) with the closed-source driver from nvidia on 
an 2.6.11.3 kernel at the moment. The nivdia is of version 6629, with a 
small change, to make it compile under 2.6.11.3. Vital is, that you use 
this option in your XF86Config:
     Option      "NvAGP" "1"
Otherwise the agpgart will hang your computer on resume, eating up to 99% 
of your CPU-cycles. I can do suspend to disk, as well as suspend to ram. 
The console does not restore, but with my script, I change to a 
virtual-text-console before suspending, and back to X-console afterwards. 
Then X will work as it should. For me, that is the important point.

Cheers
   hartwig felger

Hartwig Felger informatics
P.S.: I didn't find time to test the latest nvidia-driver yet...
- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFCQ/m19bBoTzOf1pMRAuEeAKCT2YUP1z7OxY5tE2bKMYnq06rrEgCgvhj+
zPqVziV/R+eXkbWPHo7EWrQ=
=KexP
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
