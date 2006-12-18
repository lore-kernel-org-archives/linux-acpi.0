From: Stefan Seyfried <seife@suse.de>
Subject: Re: suspend to RAM on lifebook 7110
Date: Mon, 18 Dec 2006 07:51:36 +0100
Message-ID: <20061218065136.GG26170@suse.de>
References: <20061208123358.GA3724@invalid.invalid>
	<20061208211308.GA5157@erebor.ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061208211308.GA5157@erebor.ics.muni.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Miroslav Ruda <ruda@ics.muni.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 08, 2006 at 10:13:08PM +0100, Miroslav Ruda wrote:
> On Fri, Dec 08, 2006 at 01:33:58PM +0100, Frank Ursel wrote:
> > Before i actually suspend the notebook, i write some data about the
> > graphic card on disk and on resume the data is written back to the
> > graphic card and everything works fine (I'm writing only the relevant
> > parts in here):
> > =

> >  # discover video card's ID
> >  ID=3D`lspci | grep VGA | awk '{ print $1 }' | sed -e 's@0000:@@' -e 's=
@:@/@'`
> > =

> >  # dump current data from the video card to the temporary file
> >  cat /proc/bus/pci/$ID > $TMP_FILE
> > =

> >  # suspend
> >  echo -n mem > /sys/power/state
> > =

> >  # restore video card data from the temporary file
> >  # on resume
> >  cat $TMP_FILE > /proc/bus/pci/$ID
> =

> Great, it works for me too.

OK. This is probably the same as the R50e entry in the whitelist:
        /* R50e needs not yet implemented save_video_pci_state :-(

I thought that this should somehow go away by the PCI bus suspend/resume
methods that somewhen back got merged by Greg K-H.
I still think that this belongs in the kernel and that we should not work
around this issue in s2ram. But maybe somebody who knows more about this
stuff can convince me otherwise. It should not be too hard :-)

> > Note: This works fine for me in a script, which is invoked by acpi on
> >       button-press. I'm using Debian/SID and i don't know where the rig=
ht
> >       place for manipulation on Suse is. Maybe you need to tweek a bit
> =

> Just for record (or others with the same problem :-), I'm using hibernate =

> script from swsusp2 and there I was able to use
> OnSuspend 80 /etc/hibernate/video.sh store
> OnResume 80 /etc/hibernate/video.sh restore
> into /etc/hibernate/ususpend-ram.conf script.
> =

> Or on Suse 10.2, pm-utils are used by default and it's easy to add call t=
o =

> this script to /etc/pm/hooks/ directory.

Yes, that's how it was intended to be. Easy and straightforward :-)

Best regards,

     Stefan

-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
