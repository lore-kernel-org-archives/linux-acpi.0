From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: RE: Resuming IDE devices with ACPI
Date: Tue, 10 May 2005 09:17:42 +0100
Message-ID: <1115713062.7884.72.camel@tyrosine>
References: <16A54BF5D6E14E4D916CE26C9AD3057501E5F857@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057501E5F857-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-05-10 at 08:55 +0800, Li, Shaohua wrote:

> I have an internal patch which can get IDE's ACPI device (currently only
> support PCI IDE controller) and execute _GTF, _GTM and _STM at
> suspend/resume. Unfortunately, I'm not familiar with IDE, so I don't
> know how to invoke the IDE commands returned from _GTF at resume.
> I sent an email to IDE list for help, but got no response :(.
> I believe it's a quite generic suspend/resume bug. Did anybody know
> Linux IDE in the list? If you need more info such as the IDE commands
> from one of my system, please let me know.

I /believe/ that it the buffer returned from _GTF just needs to be split
into 7-byte chunks and then fed to taskfile_output_data. This seems to
be what happens when taskfile commands are triggered by IDE ioctls (see
the hdparm or smartmontools source code, for example). Is your patch
available anywhere for testing?

Thanks,
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
