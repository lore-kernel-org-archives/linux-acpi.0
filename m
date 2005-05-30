From: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Subject: Re: question of appropriateness
Date: Mon, 30 May 2005 15:58:31 -0700
Message-ID: <1117493911.1415.29.camel@localhost.localdomain>
References: <1117244104.21648.1.camel@localhost.localdomain>
	 <20050528101450.GA19354@fingerbrecher>
	 <1117397912.24721.5.camel@localhost.localdomain>
	 <20050530130147.GH32472@poupinou.org>
	 <1117471738.398.18.camel@localhost.localdomain>
	 <20050530172536.GI32472@poupinou.org> <20050530183858.GK32472@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050530183858.GK32472-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-05-30 at 20:38 +0200, Bruno Ducrot wrote:
> On Mon, May 30, 2005 at 07:25:36PM +0200, Bruno Ducrot wrote:
> > But I'm wondering what iasl are you using?  It seems totally broken
> > to me.
> 
> Actually I am wrong here.  Later iasl (20050513) is now more
> restrictive.  When the ResourceSourceIndex exist, then ResourceSource
> must exist.
> 
> 2 solutions if you want to compile:
> 1- patch iasl in order to restore old behaviour (but this is out of
> spec somehow)
> or
> 2- eliminate all the ResourceSourceIndex when there is no ResourceSource.
> 
> For point 2, here is an incremental patch to your asl:


Bruno,

    You sir are a genius!.... combining the two patches + another minor
fix  (WAK_1 not having Return(Package(0x02){0x00, 0x00}), and I am now
running at 100% of expected.    Additional things like suspend etc need
tweaking in the script arena but not in the DSDT.  

   Other than submitting this DSDT to the wiki at acpi.sourceforge.net
for others to use is there anywhere else that I should submit it.  (Note
it compiled without errors or warnings.)  Thanks again. Now to do some
reading so that I can fully understand just what it is you did.  

James




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
