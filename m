From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: ACPI on hp tc1100
Date: Sun, 5 Dec 2004 12:24:30 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0412051210070.990@frog.athome>
References: <41B2912D.8020105@joshuawise.com>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41B2912D.8020105-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Joshua,
regarding the nvidia problem, I would recomend you searching the november 
posts to this list for a thread called "Success with kernel-swsusp and 
Nvidia-closed-source" started by me.
Just to repeat two things:
I was not sucessfull with the latest nvidia driver. I needed to use the 
nvidia agpgart with 'Option "NvAGP" "1"', as with my Acer ali-agp it would 
crash on resume.

On Sat, 4 Dec 2004, Joshua Wise wrote:
>  - If the nvidia binary-only driver has been loaded, and X has been run 
> within that cycle of loading the nvidia driver, then the system goes to 
> sleep. When commanded to wake through the power switch, the system will 
> switch to a console momentarily, print some debugging messages, then blank 
> the screen and seemingly halt.
If you login through the network and run "top" you would see, that X is 
claiming nearly 100% of CPU-cycles..., that happens, when you switch to 
the virtual-console, where the nvidia-binary-only driver is running (or if 
it is resumed to this console...) and the AGP-bus is not initialised.

As you may read often on this list, start with suspend to disk, as it is 
the easiest to get running. Then go for S1 and S3 (the S0 you mentioned is 
S1). Just always think of doing a sync before trying to suspend; then fsck 
has a lot better chances to put things together after a crash.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBsu/89bBoTzOf1pMRApUzAJ9hlkn3Ud+GKvgt/VrThnFtS3vj8QCgqQVR
vaPt0WmVkOWsUj9qfY8w63s=
=GwUm
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
